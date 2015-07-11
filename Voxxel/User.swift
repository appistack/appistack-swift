import Foundation
import SwiftyJSON

class User: NSObject, ResponseObjectSerializable {
    let id: Int
    let email: String
    let username: String
    let uid: String
    let provider: String
    
    var name: String?
    var nickname: String?
    var image: String?
    
    //createdAt
    //updatedAt
    //verified
    //artistId
    //roles
    
    init(id: Int, email: String, username: String, uid: String, provider: String) {
        self.id = id
        self.email = email
        self.username = username
        self.uid = uid
        self.provider = provider
    }
    
    required init(response: NSHTTPURLResponse, json: JSON) {
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.username = json["username"].stringValue
        self.uid = json["uid"].stringValue
        self.provider = json["provider"].stringValue
        
        self.name = json["name"].string
        self.nickname = json["nickname"].string
        self.image = json["image"].string
    }
    
    // Used by NSMutableOrderedSet to maintain the order
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! User).id == self.id
    }
    
    // Used by NSMutableOrderedSet to check for uniqueness when added to a set
    override var hash: Int {
        return (self as User).id
    }
    
    func getImageUrl() -> String {
        if image != nil {
            let assets_url = Config.conf.opts["assets_url"]
            return "\(assets_url)/\(image!)"
        } else {
            return "http://www.gravatar.com/avatar/\(Util.MD5(email))"
        }
    }

}
