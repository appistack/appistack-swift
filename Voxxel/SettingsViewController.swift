//
//  SettingsViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/12/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator
import CRToast

//TODO: merge Profile & Settings views

class SettingsViewController: UITableViewController, FormValidatable {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNickname: UITextField!
    
    @IBOutlet weak var lblNameValidation: UILabel!
    @IBOutlet weak var lblNicknameValidation: UILabel!
    
    let authManager = AuthManager.manager
    let userService = UserService()
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.text = authManager.user!.name
        txtNickname.text = authManager.user!.nickname
        
        setupValidator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressSave(sender: AnyObject) {
        if txtName.isFirstResponder() { txtName.resignFirstResponder() }
        if txtNickname.isFirstResponder() { txtNickname.resignFirstResponder() }
        
        let userId = authManager.user!.id
        let userParams = [
            "name": txtName.text!,
            "nickname": txtNickname.text!
        ]
        
        validator.validate() { (errors) in
            if errors.isEmpty {
                self.userService.update(userId, params: ["user": userParams]) { (req, res, data, err) in
                    if (err == nil) {
                        self.userService.get(userId) { (req, res, user, err) in
                            self.authManager.user = user
                            self.displayUserUpdatedNotification("Profile Updated", completionBlock: {})
                            //TODO: navigate to user profile.  However, "Show Detail" segue does not update the navigation history
                        }
                    } else {
                        self.displayUserUpdatedNotification("Profile Update Failed", completionBlock: {})
                    }
                }
            }
        }
    }
    
    func setupValidator() {
        setupValidationStyles(validator)
        
        let nameRegex = "[a-zA-Z\\s]{2,}"
        let nameRule = RegexRule(regex: nameRegex, message: "Must include at least two letters")
        
        let nicknameRegex = "(^$|[\\w\\s]{2,})"
        let nicknameRule = RegexRule(regex: nicknameRegex, message: "Requires two letters, symbols or digits")
        //TODO: allow for empty nickname
        //TODO: change nickname to length requirement
        
        validator.registerField(txtName, errorLabel: lblNameValidation, rules: [RequiredRule(), nameRule])
        validator.registerField(txtNickname, errorLabel: lblNicknameValidation, rules: [nicknameRule])
    }
    
    func displayUserUpdatedNotification(message: String, completionBlock: (() -> Void)) {
        let toastOptions: [NSObject: AnyObject] = [
            kCRToastTextKey: message,
            kCRToastNotificationTypeKey: CRToastType.NavigationBar.rawValue,
            kCRToastTextAlignmentKey: NSTextAlignment.Center.rawValue,
            kCRToastBackgroundColorKey: UIColor.grayColor(),
            kCRToastAnimationInTypeKey: CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationOutTypeKey: CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationInDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastAnimationOutDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastTimeIntervalKey: 3
        ]
        CRToastManager.showNotificationWithOptions(toastOptions, completionBlock: completionBlock)
    }
    
}