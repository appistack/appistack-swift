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
            }
        }
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
        case 0: self.performSegueWithIdentifier("showHome", sender: self)
        case 1: self.performSegueWithIdentifier("showArtists", sender: self)
        default: self.performSegueWithIdentifier("showProfile", sender: self)
        }
    }
    
    
}