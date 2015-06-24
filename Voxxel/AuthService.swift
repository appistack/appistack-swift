//
//  AuthService.swift
//  Voxxel
//
//  Created by David Conner on 6/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    let apiUrl = Config.conf.opts["api_base_url"]!
    
    //TODO: refactor using Router enum pattern?
    
    func validateToken(token:AccessTokenModel, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        Alamofire.request(.GET, URLString: apiUrl + "/auth/validate_token")
            .validate()
            .responseJSON() { (req, res, data, err) in
                //TODO: clear token if invalid (and redirect user to login?)
                //TODO: also clear headers from
                //TODO: set user returned by token to json.valueForKeyPath("data")
                //{"success":true,"data":{"id":1,"username":"dcunit3d","email":"dconner.pro@gmail.com","name":null,"nickname":null,"image":null,"provider":"email","uid":"dconner.pro@gmail.com","roles":[]}}
        }
    }
    
    func login(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, NSError?) -> Void)  {
        
        Alamofire.request(.POST, URLString: apiUrl + "/auth/sign_in", parameters: params)
            .validate()
            .responseObject() { (req, res, user: User?, err) in
                if err == nil {
                    onSuccess(res, user)
                } else {
                    onError(res, err)
                }
            }
    }
    
    func logout(onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, NSError?) -> Void) {
        
        Alamofire.request(.DELETE, URLString: apiUrl + "/auth/sign_out")
            .validate()
            .responseJSON() { (req, res, data, err) in
                if err == nil {
                    onSuccess(res, data)
                } else {
                    onError(res, err)
                }
            }
    }
    
    func signup(params: [String: AnyObject],
        onSuccess: (NSHTTPURLResponse?, AnyObject?) -> Void,
        onError: (NSHTTPURLResponse?, NSError?) -> Void) {
            
        Alamofire.request(.POST, URLString: apiUrl + "/auth", parameters: params)
            .validate()
            .responseObject() { (req, res, user: User?, err) in
                if err == nil {
                    onSuccess(res, user)
                } else {
                    onError(res, err)
                }
            }
    }
    
}
