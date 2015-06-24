//
//  ApiHelper.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Alamofire

@objc public protocol ResponseObjectSerializable {
    init(response: NSHTTPURLResponse, json: AnyObject)
}

extension Alamofire.Request {
    
    // TODO: refactor completionHandler to onSuccess/onError here? 
    //   or do i need specific error handling behavior per Api request types
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (req, res, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (json, serializationError):(AnyObject?, NSError?) = JSONSerializer(req, res, data)
            if res != nil && json != nil {
                return (T(response: res!, json: json!), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (req, res, obj, error) in
            completionHandler(req, res, obj as? T, error)
        })
    }
}
