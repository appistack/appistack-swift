//
//  Artist.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation

final class Artist: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    let apiUrl = Config.conf.opts["api_base_url"]!
    
    let id: Int
    let firstName: String
    let lastName: String
    
    var headshot: String?
    var desc: String?
    
    @objc static func collection(response response: NSHTTPURLResponse, json: AnyObject) -> [Artist] {
        var artists = [Artist]()
        
        for artist in json as! [NSDictionary] {
            artists.append(Artist(json: artist))
        }
        
        return artists
    }
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(json: AnyObject) {
        self.id = json.valueForKeyPath("id") as! Int
        self.firstName = json.valueForKeyPath("first_name") as! String
        self.lastName = json.valueForKeyPath("last_name") as! String

        self.headshot = json.valueForKeyPath("headshot") as? String
        self.desc = json.valueForKeyPath("description") as? String
    }
    
    required convenience init(response: NSHTTPURLResponse, json: AnyObject) {
        self.init(json: json)
    }
    
    func name() -> String {
        return "\(firstName) \(lastName)"
    }
    
    // Used by NSMutableOrderedSet to maintain the order
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! Artist).id == self.id
    }
    
    // Used by NSMutableOrderedSet to check for uniqueness when added to a set
    override var hash: Int {
        return (self as Artist).id
    }

}