//
//  ViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/9/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtLoginEmail: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    let authService = AuthService.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(authService.apiUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressLogin(sender: UIButton) {
        if self.txtLoginEmail.isFirstResponder() { self.txtLoginEmail.resignFirstResponder() }
        if self.txtLoginPassword.isFirstResponder() { self.txtLoginPassword.resignFirstResponder() }

        let username = self.txtLoginEmail.text
        let password = self.txtLoginPassword.text
        
        if validateLoginParams(username!, password:password!) {
            print("user: \(username) pass: \(password)")
        } else {
            print("invalid username/password")
        }
    }

    @IBAction func didPressSignup(sender: UIButton) {
        if let signupController = self.storyboard?.instantiateViewControllerWithIdentifier("SignupViewController") as? SignupViewController {
            self.presentViewController(signupController, animated:true, completion:nil)
        }
    }

    func validateLoginParams(username:String, password:String) -> Bool {
        return (username.characters.count > 0) && (password.characters.count > 0)
    }

}
