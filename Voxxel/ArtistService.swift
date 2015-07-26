//
//  ArtistService.swift
//  Voxxel
//
//  Created by David Conner on 6/22/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import Alamofire

//TODO: refactor completionHandler to handle errors in this service
//TODO: clean up error handling for API Requests

class ArtistService {
    let apiUrl = Config.conf.opts["api_base_url"]! + "/api/v1"

    func get(id:Int, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Artist?, NSError?) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/artists/\( id )")
            .responseObject(completionHandler)
    }

    func list(params: [String: AnyObject]? = nil, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, [Artist]?, NSError?) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/artists")
            .responseCollection(completionHandler)
    }

}