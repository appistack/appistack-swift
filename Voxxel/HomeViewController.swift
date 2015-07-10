//
//  ViewController.swift
//  Voxxel
//
//  Created by David Conner on 6/9/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    let authManager = AuthManager.manager
    let authService = AuthService.init()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressLogout(sender: UIButton) {
        self.authService.logout({ (res, json) in
                self.navigateToLogin()
            }, onError: { (res, json, err) in
                print("error logging out")
        })
    }
    
    func loadArtists() {
        
    }

    func navigateToLogin() {
        if let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController {
            self.navigationController!.presentViewController(loginController, animated:true, completion:nil)
        }
    }
}
