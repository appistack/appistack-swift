//
//  NavViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/6/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

protocol NavSelectionDelegate: class {
    func navSelected(navItem: String)
}

class NavViewController: UITableViewController {
    
    let authManager = AuthManager.manager
    let authService = AuthService.init()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !authManager.isLoggedIn() {
            navigateToLogin()
        } else {
            if authManager.authToken.isExpired() {
                authManager.clearAccessToken()
                navigateToLogin()
            } else {
                VoxxelApi.setAuthHeaders(authManager.getAccessToken())
                if authManager.user == nil {
                    //get user data for current session
                    authService.validateToken({(res, user) in
                        
                        }, onError: {(res, json, err) in
                            self.authManager.clearAccessToken()
                            self.navigateToLogin()
                    })
                }
            }
        }
    }
    
    func logout() {
        authService.logout({ (res, json) in
            self.navigateToLogin()
            }, onError: { (res, json, err) in
                print("error logging out")
        })
    }
    
    func navigateToLogin() {
        if let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController {
            self.navigationController!.presentViewController(loginController, animated:true, completion:nil)
        }
    }
    
    var navDelegate: NavSelectionDelegate?
    var navItems = ["Home", "Artists", "Profile", "Settings", "Logout"]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let navItem = navItems[indexPath.row]
        cell.textLabel?.text = navItem
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0: self.performSegueWithIdentifier("navigateToHome", sender: self)
        case 1: self.performSegueWithIdentifier("navigateToArtists", sender: self)
        case 2: self.performSegueWithIdentifier("navigateToProfile", sender: self)
        case 3: self.performSegueWithIdentifier("navigateToSettings", sender: self)
        case 4: self.logout()
        default: self.performSegueWithIdentifier("navigateToProfile", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navigateToHome" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! HomeViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        } else if segue.identifier == "navigateToArtists" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController!
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        } else if segue.identifier == "navigateToProfile" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController! as! ProfileViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        } else if segue.identifier == "navigateToSettings" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController! as! SettingsViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}
