//
//  JYTabBarViewController.swift
//  JYDYTabBar
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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //viewControllers!.count 在这里才有值 才能计算每个项目的宽度 才能决定她的位置
        
        setupComposeBtn()
        
        
    }
    
    private func addChildViewControllers() {
        
        let json = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json")
            
            let jsonData = NSData(contentsOfFile: json!)
            
            do {
                
                let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                
                for dict in dictArray as! [[String: String]] {
                    
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imagName: dict["imageName"]!)
                    
                }
                
            } catch {}
        
        
    }
    
    private func setupComposeBtn() {
        
        tabBar.addSubview(composeBtn)
        
        let width = tabBar.frame.width / CGFloat(viewControllers!.count)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
        
        composeBtn.frame = CGRectOffset(rect, width *  2 , 0)
        
        
    
    }
    
    private func addChildViewController(controllerName: String, title: String, imagName: String) {
        
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let className: AnyObject = NSClassFromString(nameSpace + "." + controllerName)!
            
            let vcClass = className as! UIViewController.Type
            
            let vc = vcClass.init()
            
            vc.title = title
            
            vc.tabBarItem.image = UIImage(named: imagName)
            
            vc.tabBarItem.selectedImage = UIImage(named: imagName + "_click" )
            
            tabBar.tintColor = UIColor.redColor()
            
            let nav = UINavigationController()
            
            nav.addChildViewController(vc)
            
            addChildViewController(nav)
        
        
        
    }
    
    private lazy var composeBtn: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabBar_publish_icon"), forState: .Normal)
        
       button.setImage(UIImage(named: "tabBar_publish_icon_click"), forState: .Highlighted)
        
        //button.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: .Normal)
        
        //button.setBackgroundImage(UIImage(named: "tabBar_publish_icon_click"), forState: .Highlighted)
        
        button.addTarget(self, action: #selector(composeBtnClick), forControlEvents: .TouchUpInside)
        
        return button
    
    }()
    
    // 点击＋执行的函数
    
    func composeBtnClick(sender: UIButton) {
        
       let jypopVC = JYPOPViewController()
        
        jypopVC.delegate = self
        
        jypopVC.backClosure = {
            
            print("jy")
        
        }
        
        jypopVC.popoverPresentationController?.sourceView = self.view
        
        jypopVC.popoverPresentationController?.sourceRect = CGRect(x: 10, y: 10, width: 100, height: 200)
        
        
        self.presentViewController(jypopVC, animated: true) {
            
        }
       
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

extension JYTabBarViewController: JYPOPViewControllerDelegate {

    func closeView() {
        
        
        print(self.tabBarController?.selectedIndex)
        
    }

}
