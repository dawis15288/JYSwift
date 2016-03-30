//
//  AppDelegate.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/1/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

let JYRootViewControllerSwitchNotification = "JYRootViewControllerSwitchNotification"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupAppearance()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(switchRootViewController(_:)), name: JYRootViewControllerSwitchNotification, object: nil)
        
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp("1227520346")
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = defaultController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchRootViewController(notification: NSNotification) {
        
        print("从NewFeatureViewController()中的“开始体验微博按钮”发来的通知，从这里跳转到Main控制器中开始浏览微博！")
        
        let isMainVC = notification.object as! Bool
        
        window?.rootViewController = isMainVC ? MainViewController() : WelcomeViewController()
    
    }
    
    private func defaultController() -> UIViewController {
        
        if UserAccount.loadAccount() != nil {
            
            return isNewUpdate() ? NewFeatureViewController() :  WelcomeViewController() 
        
        }
        
        return MainViewController()
    
    }
    
    private func isNewUpdate() -> Bool {
        
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        let sandboxVersion = NSUserDefaults.standardUserDefaults().valueForKey("CFBundleShortVersionString") as? String ?? "0.0"
        
        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending {
            
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            
            //defaults.synchronize()currentVersion, forKey: "CFBundleShortVersionString"
            
            return true
        
        }
        
        return false
    
    }
    
    func setupAppearance() {
    
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return WeiboSDK.handleOpenURL(url, delegate: self)
        
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        return WeiboSDK.handleOpenURL(url, delegate: self)
        
    }
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        
        if let authorizeResponse = response as? WBAuthorizeResponse {
            
            if authorizeResponse.statusCode == WeiboSDKResponseStatusCode.Success {
                
                print(authorizeResponse.userInfo)
            
            }
        
        }
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

