//
//  ProfileViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/10/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit
import Haneke


class ProfileViewController: UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    let authManager = AuthManager.manager
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUsername.text = authManager.user!.username
        imgProfile.hnk_setImageFromURL(authManager.user!.getImageURL())
    }
}
