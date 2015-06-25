//
//  SignupViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/14/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit
import SwiftValidator

class SignupViewController: UIViewController, FormValidatable {
    
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupUsername: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var txtSignupConfirm: UITextField!
    
    @IBOutlet weak var lblSignupEmail: UILabel!
    @IBOutlet weak var lblSignupUsername: UILabel!
    @IBOutlet weak var lblSignupPassword: UILabel!
    @IBOutlet weak var lblSignupConfirm: UILabel!
    
    let authService = AuthService.init()
    let authManager = AuthManager.manager
    let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupValidationStyles(validator)
        let pwdRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}"
        let pwdRule = PasswordRule(regex: pwdRegex, message: "Must include uppercase, lowercase and digits")
        let usernameRegex = "[a-zA-Z0-9]{4,20}"
        let usernameRule = RegexRule(regex: usernameRegex, message: "Must be alphanumeric and at least four characters")
        
        validator.registerField(txtSignupEmail, errorLabel: lblSignupEmail, rules: [RequiredRule(), EmailRule()])
        validator.registerField(txtSignupUsername, errorLabel: lblSignupUsername, rules: [RequiredRule(), MinLengthRule(length: 8), usernameRule]) // TODO: regexp rule
        validator.registerField(txtSignupPassword, errorLabel: lblSignupPassword, rules: [RequiredRule(), pwdRule])
        validator.registerField(txtSignupConfirm, errorLabel: lblSignupConfirm, rules: [RequiredRule(), ConfirmationRule(confirmField: txtSignupPassword)])
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
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }, onError: { (req, err) in
                        print("signup failed")
                        print(err)
                })
            }
        }
    }
    
    @IBAction func didPressCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
