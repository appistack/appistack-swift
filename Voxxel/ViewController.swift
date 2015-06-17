//
//  ViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/9/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AuthManager.isLoggedIn() {
            if let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController {
                self.navigationController?.presentViewController(loginController, animated:true, completion:nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
