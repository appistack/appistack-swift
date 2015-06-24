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
        }
    }
    
    func login(email:String, password:String, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        let params = ["email": email, "password": password]
        
        //TODO: change to success/error handler instead of single handler
        
        Alamofire.request(.POST, URLString: apiUrl + "/auth/sign_in", parameters: params)
            .validate()
            .responseObject<User>() { (req, res, data, err) in
                //TODO: update authmanager singleton token/user
                completionHandler(req, res, data, err)
        }
    }
    
    func logout(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        Alamofire.request(.DELETE, URLString: apiUrl + "/auth/sign_out")
            .validate()
            .responseJSON() { (req, res, data, err) in
                //TODO: update authmanager singleton token/user
                completionHandler(req, res, data, err)
        }
    }
    
    func signup(email:String, username:String, password:String, confirm:String,
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
            let params = ["email": email, "username": username, "password": password, "confirm": confirm]
            
            Alamofire.request(.POST, URLString: apiUrl + "/auth", parameters: params)
                .validate()
                .responseJSON(completionHandler: completionHandler)
    }
    
}
