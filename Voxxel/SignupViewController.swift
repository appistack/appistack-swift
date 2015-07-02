//
//  SignupViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/14/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit
import SwiftValidator
import CRToast

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
            "password_confirmation": self.txtSignupConfirm.text!,
            "confirm_success_url": Config.conf.opts["signup_confirm_success_url"]!,
            "config_name": "default"
        ]
        
        validator.validate() { (errors) in
            if errors.isEmpty {
                self.authService.signup(params,
                    onSuccess: { (req, user) in
                        self.displayConfirmEmailToast() { () in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    }, onError: { (req, json, err) in
                        print("signup failed")
                        print(err)
                })
            }
        }
    }

    @IBAction func didPressCancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //ui navigation controller UINavigationControllerDelegate
    // http://makeapppie.com/tag/uinavigationcontroller-in-swift/
    // http://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app
    // https://stackoverflow.com/questions/28475661/how-to-send-an-uiviewcontroller-that-conforms-uiimagepickercontrollerdelegate-u
    //        if let stack = self.navigationController?.viewControllers {
    //            let loginVc = stack[stack.count-2] as! LoginViewController
    //            loginVc.displayConfirmEmail = true
    //            self.navigationController!.popToViewController(loginVc, animated: true)
    //        }
    
    func displayConfirmEmailToast(completionBlock: (() -> Void)) {
        let toastOptions: [NSObject: AnyObject] = [
            kCRToastTextKey: "Great Success!",
            kCRToastSubtitleTextKey: "Please confirm your email address",
            kCRToastNotificationTypeKey: CRToastType.NavigationBar.rawValue,
            kCRToastTextAlignmentKey: NSTextAlignment.Center.rawValue,
            kCRToastBackgroundColorKey: UIColor.grayColor(),
            kCRToastAnimationInTypeKey: CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationOutTypeKey: CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationInDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastAnimationOutDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastTimeIntervalKey: 3
            //TODO: set fonts?
            //            kCRToastFontKey: UIFont(name: "System", size: 15) as AnyObject,
            //            kCRToastSubtitleFontKey: UIFont(name: "System", size: 12) as AnyObject,
        ]
        CRToastManager.showNotificationWithOptions(toastOptions, completionBlock: completionBlock)
    }
}
