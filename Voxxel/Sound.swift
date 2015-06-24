
//
//  Sound.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

class Sound: NSObject, ResponseObjectSerializable {
    
    let id: Int
    let artistId: Int
    let name: String
    
    var desc: String?
    
    init(id: Int, artistId: Int, name: String) {
        self.id = id
        self.artistId = artistId
        self.name = name
    }
    
    required init(response: NSHTTPURLResponse, json: AnyObject) {
        self.id = json.valueForKeyPath("id") as! Int
        self.artistId = json.valueForKeyPath("artist_id") as! Int
        self.name = json.valueForKeyPath("name") as! String
        self.desc = json.valueForKeyPath("description") as? String
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