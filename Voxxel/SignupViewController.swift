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
    
    let authService = AuthService.init()
    let authManager = AuthManager.manager

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressSignup(sender: UIButton) {
        if self.txtSignupEmail.isFirstResponder() { self.txtSignupEmail.resignFirstResponder() }
        if self.txtSignupUsername.isFirstResponder() { self.txtSignupUsername.resignFirstResponder() }
        if self.txtSignupPassword.isFirstResponder() { self.txtSignupPassword.resignFirstResponder() }
        if self.txtSignupConfirm.isFirstResponder() { self.txtSignupConfirm.resignFirstResponder() }
        
        let email = self.txtSignupEmail.text!
        let username = self.txtSignupUsername.text!
        let password = self.txtSignupPassword.text!
        let confirm = self.txtSignupConfirm.text!
        
        if validateSignupParams(email, username: username, password: password, confirm: confirm) {
            let params = ["email": email, "username": username, "password": password, "confirm": confirm]
            authService.signup(params,
                onSuccess: { (req, user) in
                
                }, onError: { (req, err) in
                    
            })
        } else {
            print("validation failed")
        }
        
    }

    @IBAction func didPressCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func validateSignupParams(email: String, username: String, password: String, confirm: String) -> Bool {
        return (email.characters.count > 0)
            && (username.characters.count > 0)
            && (password.characters.count > 0)
            && (confirm.characters.count > 0)
    }
}
