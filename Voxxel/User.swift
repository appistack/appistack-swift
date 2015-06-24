import Foundation

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
    
    required init(response: NSHTTPURLResponse, json: AnyObject) {
        self.id = json.valueForKeyPath("id") as! Int
        self.email = json.valueForKeyPath("email") as! String
        self.username = json.valueForKeyPath("username") as! String
        self.uid = json.valueForKeyPath("uid") as! String
        self.provider = json.valueForKeyPath("provider") as! String
        
        self.name = json.valueForKeyPath("name") as? String
        self.nickname = json.valueForKeyPath("nickname") as? String
        self.image = json.valueForKeyPath("image") as? String
    }
    
    // Used by NSMutableOrderedSet to maintain the order
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! User).id == self.id
    }
    
    // Used by NSMutableOrderedSet to check for uniqueness when added to a set
    override var hash: Int {
        return (self as User).id
    }

}
