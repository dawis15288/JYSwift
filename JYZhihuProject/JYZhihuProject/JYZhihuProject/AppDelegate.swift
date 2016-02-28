//
//  AppDelegate.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

import PKRevealController

import Haneke

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        let rightController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("rightViewController") as! ViewsController
        
        let leftViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("leftViewController") as! LeftViewController
        
        rightController.leftViewController = leftViewController
        
        
        let navController = self.window?.rootViewController as? UINavigationController
        
        let revealController = PKRevealController(frontViewController: rightController, leftViewController: leftViewController)
        
        revealController.setMinimumWidth((self.window?.frame.width)! * 0.6, maximumWidth: (self.window?.frame.width)! * 0.6, forViewController: leftViewController)
         
        navController?.pushViewController(revealController, animated: true)
        
        loadStartImage(LAUNCH_IMAGE_URL, onSuccess: { (name, image) -> Void in
            
            self.window?.rootViewController = LaunchImageViewController.addTransitionToViewControllr(navController!, modalTransitionStyle: UIModalTransitionStyle.CrossDissolve, withImagData: image, withSourceNam: name)
        
        })
        
        return true
    }
    
    func loadStartImage(url: String, onSuccess:(String, UIImage) -> Void) {
        
        var data: NSData?
        
        do {
            
            data = try NSURLSession.sharedSession().sendSynchronousDataTaskWithURL(NSURL(string: url)!)
        
        } catch _ {
        
            data = nil
            
        }
        
        if let temp = data {
        
            let json = JSON(data: temp)
            
            let imageURL = json["img"].string
            
            let name = json["text"].string
            
            if let imageURL = imageURL {
                
                let imageCaches = Shared.imageCache
                
                imageCaches.fetch(URL: NSURL(string: imageURL)!).onSuccess( { (image) -> Void in
                
                    onSuccess(name!, image)
                
                }).onFailure( { (failer) -> Void in
                    
                    do {
                        
                        data = try NSURLSession.sharedSession().sendSynchronousDataTaskWithURL(NSURL(string:  imageURL)!)
                        
                    } catch let e {
                        
                        print(e)
                        
                    }
                    
                    if let d = data, image = UIImage(data: d) {
                        
                        imageCaches.set(value: image, key: imageURL)
                        
                    }
                })
                
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

