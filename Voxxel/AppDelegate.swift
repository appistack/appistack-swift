//
//  AppDelegate.swift
//  Voxxel
//
//  Created by David Conner on 6/9/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        
        //TODO: assign the splitViewController somewhere else besides AppDelegate?
        splitViewController.delegate = self
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    }

    func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    }

    func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // This method is called when a split view controller is collapsing its children for a transition to a compact-width size class. Override this
    // method to perform custom adjustments to the view controller hierarchy of the target controller.  When you return from this method, you're
    // expected to have modified the `primaryViewController` so as to be suitable for display in a compact-width split view controller, potentially
    // using `secondaryViewController` to do so.  Return YES to prevent UIKit from applying its default behavior; return NO to request that UIKit
    // perform its default collapsing behavior.
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? HomeViewController {
//                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    //If we don't do this, detail1 will open as the first view when run on iPhone, comment and see
                    return true
//                }
            }
        }
        return false
    }
    
    // This method is called when a split view controller is separating its child into two children for a transition from a compact-width size
    // class to a regular-width size class. Override this method to perform custom separation behavior.  The controller returned from this method
    // will be set as the secondary view controller of the split view controller.  When you return from this method, `primaryViewController` should
    // have been configured for display in a regular-width split view controller. If you return `nil`, then `UISplitViewController` will perform
    // its default behavior.
//    // Correctly Handle Portrait to Landscape transition for iPhone 6+ when TableView2 is open in Portrait. Comment and see for yourself, what happens when you don't write this.
//    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
//        if let primaryAsNavController = primaryViewController as? UINavigationController {
//            if let topAsTableViewController = primaryAsNavController.topViewController as? TableViewController2 {
//                //Return Navigation controller containing DetailView1 to be used as secondary view for Split View
//                return (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detail1Nav") as! UIViewController)
//            }
//        }
//        return nil
//    }

}
