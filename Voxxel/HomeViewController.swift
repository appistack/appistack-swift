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
//
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if !authManager.isLoggedIn() {
//            navigateToLogin()
//        } else {
//            let token = authManager.getAccessToken()
//            print(token.token)
//            print(token.client)
//            VoxxelApi.setAuthHeaders(authManager.getAccessToken())
//            authService.validateToken({(res, json) in
//                self.loadArtists()
//                }, onError: {(res, json, err) in
//                    self.navigateToLogin()
//                    })
//        }
//    }

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
