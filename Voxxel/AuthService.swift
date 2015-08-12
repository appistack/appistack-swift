//
//  AuthService.swift
//  Voxxel
//
//  Created by David Conner on 6/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//;

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    let apiUrl = Config.conf.opts["api_base_url"]!
    
    func validateToken(onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.GET, apiUrl + "/auth/validate_token")
            .validate()
            .responseJSON() { (req, res, result) in
                //TODO: clear token if invalid (and redirect user to login?)
                //TODO: also clear headers from
                //TODO: set user returned by token to json.valueForKeyPath("data")
                switch result {
                case .Success(let value):
                    let data = value.valueForKeyPath("data")
                    let user = User(response: res!, json: JSON(data!))
                    AuthManager.manager.user = user
                    onSuccess(res, user)
                case .Failure(let data, let err):
                    AuthManager.manager.clearAccessToken()
                    onError(res, data, err)
                }
            }
    }
    
    func login(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.POST, apiUrl + "/auth/sign_in", parameters: params)
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success(let value):
                    let data = value.valueForKeyPath("data")
                    let user = User(response: res!, json: JSON(data!))
                    let accessToken = AccessTokenModel.parseFromHeaders(res!)
                    AuthManager.manager.setAccessToken(accessToken)
                    AuthManager.manager.user = user
                    onSuccess(res, user)
                case .Failure(let data, let err):
                    onError(res, data, err)
                }
            }
    }
    
    func logout(onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        
        VoxxelApi.manager.request(.DELETE, apiUrl + "/auth/sign_out")
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success(let value):
                    AuthManager.manager.clearAccessToken()
                    onSuccess(res, value)
                case .Failure(let data, let err):
                    onError(res, data, err)
                }
            }
    }
    
    func signup(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.POST, apiUrl + "/auth", parameters: params)
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success(let value):
                    AuthManager.manager.clearAccessToken()
                    let data = value.valueForKeyPath("data")
                    let user = User(response: res!, json: JSON(data!))
                    onSuccess(res, user)
                case .Failure(let data, let err):
                    onError(res, data, err)
                }
            }
    }
}
