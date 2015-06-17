//
//  Config.swift
//  Voxxel
//
//  Created by David Conner on 6/17/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

class Config {
    static let conf = Config()

    var opts: [String:String]

    init() {
        self.opts = Config.loadDefaults()
    }

    func getKey(key:String) -> String? {
        return self.opts[key]!
    }

    class func loadDefaults() -> Dictionary<String,String> {
        let plistName = NSBundle.mainBundle().objectForInfoDictionaryKey("ConfigPlist") as! String
        let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
        return NSDictionary(contentsOfFile: path!) as! [String:String]
    }

}
