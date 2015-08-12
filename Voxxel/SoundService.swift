//
//  SoundService.swift
//  Voxxel
//
//  Created by David Conner on 7/19/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import Alamofire

class SoundService {
    let apiUrl = Config.conf.opts["api_base_url"]! + "/api/v1"
    
    func get(id:Int, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<Sound>) -> Void) {
        VoxxelApi.manager.request(.GET, apiUrl + "/sounds/\( id )")
            .responseObject(completionHandler)
    }
    
}