//
//  JYTabBarViewController.swift
//  JY-自定义tabbar
//
//  Created by atom on 16/4/18.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewControllers()
    }
    
    
    private func addChildViewControllers() {
        
        if let json = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json") {
            
            let jsonData = NSData(contentsOfFile: json)
            
            do {
                
                let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                
                for dict in dictArray as! [[String: String]] {
                    
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imagName: dict["imageName"]!)
                
                }
            
            } catch {}
        
        }
        
        
        
        
    
        
    }
    
    private func addChildViewController(controllerName: String, title: String, imagName: String) {
        
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let className: AnyObject = NSClassFromString(nameSpace + "." + controllerName)!
        
        let vcClass = className as! UIViewController.Type
        
        let vc = vcClass.init()
        
        vc.title = title
        
        vc.tabBarItem.image = UIImage(named: imagName)
        
        vc.tabBarItem.selectedImage = UIImage(named: imagName + "_highlighted" )
        
        tabBar.tintColor = UIColor.orangeColor()
        
        let nav = UINavigationController()
        
        nav.addChildViewController(vc)
        
        addChildViewController(nav)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
