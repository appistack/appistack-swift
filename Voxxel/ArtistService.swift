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
    let apiUrl = Config.conf.opts["api_base_url"]!
    
    //TODO: refactor using Router enum pattern?
    //TODO: refactor completionHandler to handle errors in this service and accept the model(s) as params
    func get(id:Int, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        Alamofire.request(.GET, URLString: apiUrl + "/api/v1/artists/\( id ).json")
            .responseJSON(completionHandler: completionHandler)
    }

    func list(params: [String: AnyObject]? = nil, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        Alamofire.request(.GET, URLString: apiUrl + "/api/v1/artists.json", parameters: params)
            .responseJSON(completionHandler: completionHandler)
    }

}