//
//  AppDelegate.swift
//  JYSplitProject
//
//  Created by atom on 16/2/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    
    var spliteViewController: UISplitViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        spliteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idSplitViewController") as? UISplitViewController
        
        spliteViewController?.delegate = self
        
        spliteViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        let containerViewController: ContainerViewController = ContainerViewController()
        
        containerViewController.setEmbeddeViewController(spliteViewController)
        
        window?.rootViewController = containerViewController
        
        return true
    }
    
    //实现在应用启动的时候显示主视图
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        
        return true
    }
    
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        
        print("targetDisplayModeForActionInSplitViewController -----> \(svc)\n\n\n")
        return UISplitViewControllerDisplayMode.PrimaryHidden
        
    }
    
    func splitViewController(svc: UISplitViewController,  willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        
        print("------->willChangeToDisplayMode<------\n\n\n")
        
        NSNotificationCenter.defaultCenter().postNotificationName("PrimaryVCDisplayModeChangeNotification", object: NSNumber(integer: displayMode.rawValue))
        
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


}
