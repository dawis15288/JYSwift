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
        
        //加载控制器，
        
        addChildViewControllers()
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
    
   //MARK:  tarbar中间的＋按钮
    
    private lazy var composeBtn: UIButton = {
        
      // 设置＋的属性
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        button.addTarget(self, action: #selector(composeBtnClick), forControlEvents: .TouchUpInside)
        
        return button
    
    }()
    
    // 点击＋执行的函数
    
    func composeBtnClick(sender: UIButton) {
        
        // 这里要判断是否登录
        
        if  !login {
            
            let composeVC = ComposeViewController()
            
            let navVC = UINavigationController(rootViewController: composeVC)
            
            //let emojiVc = EmojiViewController()
            
            presentViewController(navVC, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
    //MARK:  添加控制器函数
    
    func addChildViewControllers() {
        
        //从json文件中获取要加在tabbar上面的控制器
        
        let json = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json")
        
        //把json数据转换data
        
        let jsonData = NSData(contentsOfFile: json!)
        
        
        
        do {
            
            //解析数据需要捕获异常
            
            let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers)
            
            //得到一个数组
            
            for dict in dictArray as! [[String: String]] {
                
                // 从数组中得到包含控制器的d
                addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                
            }
            
        } catch {
            
            // 如果失败，通过下面方式添加
            
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
        let cls: AnyClass = NSClassFromString(namespacce + "." + childControllerName)!
        //null控制器不是UITableViewController
        let vcCls = cls as! UIViewController.Type
        //csh初始化控制器
        let vc = vcCls.init()
            //设置控制器的标题
            vc.title = title
        //设置控制器在tabBar上的图标
            vc.tabBarItem.image = UIImage(named: imageName)
        //设置控制器在tabBar上的点击时的图标
            vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        //tabBar上的图标的tintColor
            tabBar.tintColor = UIColor.orangeColor()
        //初始化一个导航控制器
            let nav = UINavigationController()
        //设置根控制器
            nav.addChildViewController(vc)
        //tarbar添加导航控制器作为子控制器
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

}
