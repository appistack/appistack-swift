//
// Created by David Conner on 6/11/15.
// Copyright (c) 2015 Voxxel. All rights reserved.
//

import Foundation

class AccessTokenModel : NSObject {
    var token:String?
    var tokenType:String?
    var client:String?
    var expiry:String?
    var uid:String?
    
    static func parseFromHeaders(res: NSHTTPURLResponse) -> AccessTokenModel {
        let headers = res.allHeaderFields
        let aToken = AccessTokenModel()
        aToken.token = headers["Access-Token"] as? String
        aToken.tokenType = headers["Token-Type"] as? String
        aToken.client = headers["Client"] as? String
        aToken.expiry = headers["Expiry"] as? String
        aToken.uid = headers["Uid"] as? String
        return aToken
    }
    
    func getAuthHeaders() -> [NSObject: AnyObject] {
        let authHeaders: [NSObject: AnyObject] = [
            "Content-Type": "application/json;charset=UTF-8",
            "Accept": "application/json,text/plain;version=1",
            "access-token": self.token!,
            "token-type": self.tokenType!,
            "client": self.client!,
            "expiry": self.expiry!,
            "uid": self.uid!
        ]
        
        return authHeaders
    }
    
    func isExpired() -> Bool {
        let seconds = NSDate().timeIntervalSince1970
        return Int64(seconds) > Int64(self.expiry!)
    }
}
