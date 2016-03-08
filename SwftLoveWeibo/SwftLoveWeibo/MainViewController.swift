//
//  MainViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.tintColor

        // Do any additional setup after loading the view.
        
        addChildViewControllers()
        
        print("------>\(tabBar.subviews)<------")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        setupComposeBtn()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupComposeBtn() {
        
        tabBar.addSubview(composeBtn)
        
        let width = tabBar.bounds.width / CGFloat(viewControllers!.count)
        
        //let width = CGFloat(integerLiteral: 75)
        
        //print(viewControllers!.count)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
        //let rect = CGRect(x: 0, y: 0, width: width, height: 49)
        
        
        composeBtn.frame = CGRectOffset(rect, width *  2, 0)
    
    }
    
    private lazy var composeBtn: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        button.addTarget(self, action: "composeBtnClick:", forControlEvents: .TouchUpInside)
        
        return button
    
    }()
    
    func composeBtnClick(sender: UIButton) {
        
        print(__FUNCTION__)
        
        
        
    }
    
    func addChildViewControllers() {
        
        let json = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: json!)
        
        print(jsonData)
        
        do {
            
            let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers)
            
            
            
            for dict in dictArray as! [[String: String]] {
            
                print(dict)
            
                addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
            
            }
            
        } catch {
            
            addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            // 添加占位控制器
            addChildViewController("NullViewController", title: "", imageName: "")
            addChildViewController("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            
        }
    
    }
    
    func addChildViewController(childControllerName: String, title: String, imageName: String) {
        
        //命名空间（应用名）
        let namespacce = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        print("namespacce ---->>> \(namespacce)")
        
        let cls: AnyClass = NSClassFromString(namespacce + "." + childControllerName)!
        
        print("cls ---->>>> \(childControllerName)")
        
        //let vcCls = cls as! UITableViewController.Type
        //null控制器不是UITableViewController
        let vcCls = cls as! UIViewController.Type
        
        let vc: UIViewController!
        
        if NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") == nil {
            
            vc = BaseViewController()
            
            
            
        } else {
        
            vc = vcCls.init()
        
        }
        
        
        
        
            
            print("weiboAccessToken \(vc) ")
            
            //vc.view = VisitorView(frame: vc.view.frame)
            
            vc.title = title
            
            vc.tabBarItem.image = UIImage(named: imageName)
            
            vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
            
            tabBar.tintColor = UIColor.orangeColor()
            
            let nav = UINavigationController()
            
            nav.addChildViewController(vc)
            
            addChildViewController(nav)
        
    
    }
    
    
    
    func addChildViewController(childController: UIViewController, title: String, imagename: String) {
        
        childController.title = title
        
        childController.tabBarItem.image = UIImage(named: imagename)
        
        childController.tabBarItem.selectedImage = UIImage(named: imagename + "_highlighted")
        
        tabBar.tintColor = UIColor.orangeColor()
        
        let nav = UINavigationController()
        
        nav.addChildViewController(childController)
        
        addChildViewController(nav)
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
