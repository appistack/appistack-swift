//
//  AuthService.swift
//  Voxxel
//
//  Created by David Conner on 6/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

class AuthService {
    var apiUrl:String
    
    init() {
        print(Config.conf.opts)
        apiUrl = Config.conf.opts["api_base_url"]!;
        print(apiUrl)
//        apiUrl = config.getKey("api_base_url")
//        print(AuthService.apiUrl)
    }
    
    func validateToken(token:AccessTokenModel) -> Bool {
        return false
    }
    
    func login(username:String, password:String) -> AccessTokenModel? {
        
        return nil
    }
    
    func logout() -> Bool {
        return false
    }
    
}