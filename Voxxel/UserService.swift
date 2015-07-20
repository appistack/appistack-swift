//
//  UserService.swift
//  Voxxel
//
//  Created by David Conner on 7/20/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

//TODO: refactor completionHandler to handle errors in this service
//TODO: clean up error handling for API Requests

class UserService {
    let apiUrl = Config.conf.opts["api_base_url"]! + "/api/v1"
    
    func get(id:Int, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, User?, NSError?) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/users/\( id ).json")
            .responseObject(completionHandler)
    }
    
    func list(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, [User]?, NSError?) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/users.json")
            .responseCollection(completionHandler)
    }
    
    func update(id:Int, params: [String: AnyObject], completionHandler: (NSURLRequest?, NSHTTPURLResponse?, User?, NSError?) -> Void) {
        VoxxelApi.manager.request(.PATCH, apiUrl + "/users/\( id ).json", parameters: params)
            .validate()
            .responseObject(completionHandler)
    }
    
}