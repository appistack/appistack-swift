import Foundation
import SwiftyJSON

final class User: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable, Photoable {
    let id: Int
    let email: String
    let username: String
    let uid: String
    let provider: String
    
    var name: String?
    var nickname: String?
    var image: String?
    var gravatarUrl: String?
    
    var photo: UIImage?
    
    //createdAt
    //updatedAt
    //verified
    //artistId
    //roles
    
    static func collection(response response: NSHTTPURLResponse, json: JSON) -> [User] {
        var users = [User]()
        
        for (_, user) in json {
            users.append(User(json: user))
        }
        
        return users
    }
    
    init(id: Int, email: String, username: String, uid: String, provider: String) {
        self.id = id
        self.email = email
        self.username = username
        self.uid = uid
        self.provider = provider
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.username = json["username"].stringValue
        self.uid = json["uid"].stringValue
        self.provider = json["provider"].stringValue
        
        self.name = json["name"].string
        self.nickname = json["nickname"].string
        self.image = json["image"].string
        self.gravatarUrl = json["gravatar_url"].string
    }
    
    required convenience init(response: NSHTTPURLResponse, json: JSON) {
        self.init(json: json)
    }
    
    // Used by NSMutableOrderedSet to maintain the order
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! User).id == self.id
    }
    
    // Used by NSMutableOrderedSet to check for uniqueness when added to a set
    override var hash: Int {
        return (self as User).id
    }
    
    func getImageURL() -> NSURL! {
        if image != nil {
            let assetsUrl = Config.conf.opts["assets_url"]
            return NSURL(string: "\(assetsUrl)/\(image!)")!
        } else {
            return NSURL(string: "\(gravatarUrl!)&s=256")!
        }
    }

}
