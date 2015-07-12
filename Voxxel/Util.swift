//
//  Util.swift
//  Voxxel
//
//  Created by David Conner on 7/10/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

//misc functions

class Util {
    class func MD5(string: String) -> String {
        let data = (string as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result.bytes)
        CC_MD5(data.bytes, CC_LONG(data.length), resultBytes)
        
        let a = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result.length)
        let hash = NSMutableString()
        
        for i in a {
            hash.appendFormat("%02x", i)
        }
        
        return hash as String
    }
}
