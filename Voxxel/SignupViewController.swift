//
//  SignupViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/14/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit
import SwiftValidator

class SignupViewController: UIViewController {
    
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupUsername: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var txtSignupConfirm: UITextField!
    
    let authService = AuthService.init()
    let authManager = AuthManager.manager
    let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        validator.registerField(txtSignupEmail, rules: [RequiredRule(), EmailRule()])
        validator.registerField(txtSignupUsername, rules: [RequiredRule()]) // TODO: regexp rule
        validator.registerField(txtSignupPassword, rules: [RequiredRule(), PasswordRule()])
        validator.registerField(txtSignupConfirm, rules: [RequiredRule()]) //TODO: confirm rule
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
        
        let params = [
            "email": self.txtSignupEmail.text!,
            "username": self.txtSignupUsername.text!,
            "password": self.txtSignupPassword.text!,
            "password_confirmation": self.txtSignupConfirm.text!
        ]
        
        validator.validate() { (errors) in
            if errors.isEmpty {
                self.authService.signup(params,
                    onSuccess: { (req, user) in
                        //transition to LoginController with notification to confirm email addy
                    }, onError: { (req, err) in
                        print("signup failed")
                        print(err)
                })
            } else {
                print("validation failed")
            }
        }
    }

    @IBAction func didPressCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
