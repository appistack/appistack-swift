//
//  ArtistService.swift
//  Voxxel
//
//  Created by David Conner on 6/22/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import Alamofire

class ArtistService {
    let apiUrl = Config.conf.opts["api_base_url"]! + "/api/v1"
    
    //TODO: refactor using Router enum pattern?
    //TODO: refactor completionHandler to handle errors in this service and accept the model(s) as params
    func get(id:Int, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Artist?, NSError?) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/artists/\( id ).json")
            .responseObject(completionHandler)
    }

    func list(params: [String: AnyObject]? = nil, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, [Artist]?, NSError?) -> Void) {
        Alamofire.request(.GET, URLString: apiUrl + "/artists.json", parameters: params)
            .responseCollection(completionHandler)
    }

}