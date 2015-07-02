//
//  AuthService.swift
//  Voxxel
//
//  Created by David Conner on 6/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//;

import Foundation
import Alamofire

class AuthService {
    let apiUrl = Config.conf.opts["api_base_url"]!
    
    func validateToken(onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.GET, apiUrl + "/auth/validate_token")
            .validate()
            .responseJSON() { (req, res, json, err) in
                //TODO: clear token if invalid (and redirect user to login?)
                //TODO: also clear headers from
                //TODO: set user returned by token to json.valueForKeyPath("data")
                if err == nil && json != nil {
                    let data = json!.valueForKeyPath("data")
                    let user = User(response: res!, json: data!)
                    AuthManager.manager.user = user
                    onSuccess(res, user)
                } else {
                    AuthManager.manager.clearAccessToken()
                    onError(res, json, err)
                }
        }
    }
    
    func login(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.POST, apiUrl + "/auth/sign_in", parameters: params)
            .validate()
            .responseJSON() { (req, res, json, err) in
                if err == nil && json != nil {
                    let data = json!.valueForKeyPath("data")
                    let user = User(response: res!, json: data!)
                    let accessToken = AccessTokenModel.parseFromHeaders(res!)
                    AuthManager.manager.setAccessToken(accessToken)
                    AuthManager.manager.user = user
                    onSuccess(res, user)
                } else {
                    onError(res, json, err)
                }
            }
    }
    
    func logout(onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        
        VoxxelApi.manager.request(.DELETE, apiUrl + "/auth/sign_out")
            .validate()
            .responseJSON() { (req, res, json, err) in
                if err == nil {
                    AuthManager.manager.clearAccessToken()
                    onSuccess(res, json)
                } else {
                    onError(res, json, err)
                }
            }
    }
    
    func signup(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {

        VoxxelApi.manager.request(.POST, apiUrl + "/auth", parameters: params)
            .validate()
            .responseJSON() { (req, res, json, err) in
                if err == nil && json != nil {
                    let data = json!.valueForKeyPath("data")
                    let user = User(response: res!, json: data!)
                    onSuccess(res, user)
                } else {
                    onError(res, json, err)
                }
            }
    }
}
