
//
//  UIHelper.swift
//  Voxxel
//
//  Created by David Conner on 6/24/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import SwiftValidator

public protocol FormValidatable {
    func setupValidationStyles(validator: Validator)
}

extension FormValidatable {
    
    func setupValidationStyles(validator: Validator) {
        validator.styleTransformers(success: { (rule) -> Void in
            rule.errorLabel?.hidden = false
            rule.errorLabel?.text = ""
            validationError.textField.layer.borderColor = UIColor.blackColor().CGColor
            rule.textField.layer.borderWidth = 0
            }, error: { (err) -> Void in
                err.errorLabel?.hidden = false
                err.errorLabel?.text = err.errorMessage
                err.textField.layer.borderColor = UIColor.redColor().CGColor
                err.textField.layer.borderWidth = 1.0
        })
    }
    
}
