//
//  ApiHelper.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Alamofire
import SwiftyJSON
//import Dollar

public protocol ResponseObjectSerializable: AnyObject {
    init(response: NSHTTPURLResponse, json: JSON)
}

public protocol ResponseCollectionSerializable: AnyObject {
    //TODO: any way to do this without using [Self] and forcing classes to be final?
    static func collection(response response: NSHTTPURLResponse, json: JSON) -> [Self]
}

extension Alamofire.Request {
    // TODO: refactor completionHandler to onSuccess/onError here? 
    //   or do i need specific error handling behavior per Api request types
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (req, res, data) in
            //TODO: handle when data is nil?
            let json = JSON(data: data!)
            if res != nil && json != nil {
                return (T(response: res!, json: json), nil)
            } else {
                return (nil, json.error)
            }
        }

        return response(serializer: serializer, completionHandler: { (req, res, obj, error) in
            completionHandler(req, res, obj as? T, error)
        })
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, [T]?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (req, res, data) in
            let json = JSON(data: data!)
            if res != nil && json != nil {
                return (T.collection(response: res!, json: json), nil)
            } else {
                return (nil, json.error)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (req, res, obj, error) in
            completionHandler(req, res, obj as? [T], error)
        })
    }
}

class VoxxelApi: NSObject {
    
    static var manager: Alamofire.Manager = VoxxelApi.defaultManager()
    
    static func defaultManager() -> Alamofire.Manager {
        let defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        
        return Alamofire.Manager(configuration: configuration)
    }
    
    static func setAuthHeaders(authToken:AccessTokenModel) {
        let defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //TODO: switch to Dollar when it's available for swift 2.0
        //configuration.HTTPAdditionalHeaders = $.merge(defaultHeaders, authToken.getAuthHeaders())
        var headers = defaultHeaders
        for (k, v) in authToken.getAuthHeaders() {
            headers[k] = v
        }
        
        configuration.HTTPAdditionalHeaders = headers
        VoxxelApi.manager = Alamofire.Manager(configuration: configuration)
    }
    
    static func clearAuthHeaders() {
        VoxxelApi.manager = defaultManager()
    }
}