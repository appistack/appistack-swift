//
//  Artist.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Artist: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable, Photoable {
    let apiUrl = Config.conf.opts["api_base_url"]!
    let assetsUrl = Config.conf.opts["assets_url"]!
    
    let id: Int
    let firstName: String
    let lastName: String
    
    var headshot: String?
    var desc: String?
    
    var photo: UIImage?
    
    static func collection(response response: NSHTTPURLResponse, json: JSON) -> [Artist] {
        var artists = [Artist]()
        
        for (_, artist) in json {
            artists.append(Artist(json: artist))
        }
        
        return artists
    }
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue

        self.headshot = json["headshot"].string
        self.desc = json["description"].string
    }
    
    required convenience init(response: NSHTTPURLResponse, json: JSON) {
        self.init(json: json)
    }
    
    func name() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func headshotUrl() -> NSURL! {
        return NSURL(string: "\(assetsUrl)\(headshot!)")!
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