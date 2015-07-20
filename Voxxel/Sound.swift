
//
//  Sound.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Sound: NSObject, ResponseObjectSerializable {
    let assetsUrl = Config.conf.opts["assets_url"]!
    
    let id: Int
    let artistId: Int
    let name: String
    let audiofile: String
    
    var desc: String?

    init(id: Int, artistId: Int, name: String, audiofile: String) {
        self.id = id
        self.artistId = artistId
        self.name = name
        self.audiofile = audiofile
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.artistId = json["artist_id"].intValue
        self.name = json["name"].stringValue
        self.desc = json["description"].string
        self.audiofile = json["audiofile"].stringValue
    }
    
    required convenience init(response: NSHTTPURLResponse, json: JSON) {
        self.init(json: json)
    }
    
    func audiofileUrl() -> NSURL! {
        return NSURL(string: "\(assetsUrl)\(audiofile)")!
    }
    
    // Used by NSMutableOrderedSet to maintain the order
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! Sound).id == self.id
    }
    
    // Used by NSMutableOrderedSet to check for uniqueness when added to a set
    override var hash: Int {
        return (self as Sound).id
    }

}