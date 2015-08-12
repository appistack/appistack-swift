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
    
    func validateToken(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void) {

        VoxxelApi.manager.request(.GET, apiUrl + "/auth/validate_token")
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success(let value):
                    let data = value.valueForKeyPath("data")
                    let user = User(response: res!, json: JSON(data!))
                    AuthManager.manager.user = user
                    completionHandler(req, res, .Success(user))
                case .Failure:
                    AuthManager.manager.clearAccessToken()
                    completionHandler(req,res,result)
                }
            }
    }
    
    func login(params: [String: AnyObject], completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void) {

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
                    completionHandler(req, res, .Success(user))
                case .Failure:
                    completionHandler(req, res, result)
                }
            }
    }
    
    func logout(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void) {
        
        VoxxelApi.manager.request(.DELETE, apiUrl + "/auth/sign_out")
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success:
                    AuthManager.manager.clearAccessToken()
                case .Failure:
                    break;
                }
                completionHandler(req, res, result)
            }
    }
    
    func signup(params: [String: AnyObject], completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void) {

        VoxxelApi.manager.request(.POST, apiUrl + "/auth", parameters: params)
            .validate()
            .responseJSON() { (req, res, result) in
                switch result {
                case .Success(let value):
                    AuthManager.manager.clearAccessToken()
                    let data = value.valueForKeyPath("data")
                    let user = User(response: res!, json: JSON(data!))
                    completionHandler(req, res, .Success(user))
                case .Failure:
                    completionHandler(req, res, result)
                }
            }
    }
}
