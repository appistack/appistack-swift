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
    init?(response: NSHTTPURLResponse, json: JSON)
}

public protocol ResponseCollectionSerializable: AnyObject {
    //TODO: any way to do this without using [Self] and forcing classes to be final?
    static func collection(response response: NSHTTPURLResponse, json: JSON) -> [Self]
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<T>) -> Void) -> Self {
        let serializer = GenericResponseSerializer<T> { (req, res, data) in
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(req,res,data)
            
            switch result {
            case .Success(let value):
                if let response = res, responseObject = T(response: response, json: JSON(value)) {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let err = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(data, err)
                }
            case .Failure(let data, let err):
                return .Failure(data, err)
            }
        }

        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<[T]>) -> Void) -> Self {
        let serializer = GenericResponseSerializer<[T]> { (req, res, data) in
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(req,res,data)
            
            switch result {
            case .Success(let value):
                if let response = res {
                    return .Success(T.collection(response: response, json: JSON(value)))
                } else {
                    let failureReason = "Response collection could not be serialized because of nil response"
                    let err = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(data, err)
                }
            case .Failure(let data, let err):
                return .Failure(data, err)
            }
        }
        
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
}

class VoxxelApi: NSObject {
    
    static var manager: Alamofire.Manager = VoxxelApi.defaultManager()
    
    static func defaultManager() -> Alamofire.Manager {
        let defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        var headers = defaultHeaders
        headers["Content-Type"] = "application/json;charset=UTF-8"
        headers["Accept"] = "application/json,text/plain;version=1"
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        
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