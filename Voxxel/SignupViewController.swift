//
//  SignupViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/14/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupUsername: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var txtSignupConfirm: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressSignup(sender: UIButton) {
        
    }

    @IBAction func didPressCancel(sender: UIButton) {
        if let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController {
            self.presentViewController(loginController, animated:true, completion:nil)
        }
    }
}
