//
//  ViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/9/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit
import SwiftValidator

class LoginViewController: UIViewController, FormValidatable {
    
    @IBOutlet weak var txtLoginEmail: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    @IBOutlet weak var lblLoginEmail: UILabel!
    @IBOutlet weak var lblLoginPassword: UILabel!
    
    let authService = AuthService.init()
    let authManager = AuthManager.manager
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: add error labels
        //TODO: setup to allow login with username
        setupValidationStyles(validator)
        validator.registerField(txtLoginEmail, errorLabel: lblLoginEmail, rules: [RequiredRule(), EmailRule()])
        validator.registerField(txtLoginPassword, errorLabel: lblLoginPassword, rules: [RequiredRule()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressLogin(sender: UIButton) {
        if self.txtLoginEmail.isFirstResponder() { self.txtLoginEmail.resignFirstResponder() }
        if self.txtLoginPassword.isFirstResponder() { self.txtLoginPassword.resignFirstResponder() }
        
        let params = [
            "email": self.txtLoginEmail.text!,
            "password": self.txtLoginPassword.text!
        ]
        
        validator.validate() { (errors) in
            if errors.isEmpty {
                self.authService.login(params,
                    onSuccess: { (res, user) in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }, onError: { (res, json, err) in
                        print(res)
                        print("login failed")
                        print(err)
                })
            }
        }
    }
    
    @IBAction func didPressSignup(sender: UIButton) {
        if let signupController = self.storyboard?.instantiateViewControllerWithIdentifier("SignupViewController") as? SignupViewController {
            self.presentViewController(signupController, animated:true, completion:nil)
        }
    }
    
}
