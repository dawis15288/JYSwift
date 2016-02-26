//
//  JYMainViewController.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYMainViewController: UITabBarController {
    
    var myTabBar: UIView?
    
    var slider: UIView?
    
    let btnBGColor: UIColor = UIColor(red: 125/255.0, green: 236/255.0, blue: 198/255.0, alpha: 1)
    
    let tabBarBGColor: UIColor = UIColor(red: 251/255.0, green: 173/255.0, blue: 69/255.0, alpha: 1)
    
    let titleColor: UIColor =  UIColor(red: 52/255.0, green: 156/255.0, blue: 150/255.0, alpha: 1)
    
    let itemArray = ["最新", "热门", "真相", "关于"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "最新"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemeted")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setViews()
        
        initViewController()
        
    }
    
    func setViews() {
    
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tabBar.hidden = true
        
        let width = self.view.frame.size.width
        
        let height = self.view.frame.size.height
        
        self.myTabBar = UIView(frame: CGRectMake(0, height-49, width, 49))
        
        self.myTabBar?.backgroundColor = tabBarBGColor
        
        self.slider = UIView(frame: CGRectMake(0,0,80,49))
        
        self.slider?.backgroundColor = UIColor.whiteColor()
        
        self.myTabBar?.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabBar!)
        
        let count = self.itemArray.count
        
        for var index = 0; index < count; index++ {
            
            let btnWidth = (CGFloat)(index * 80)
            
            let button = UIButton(type: .Custom)
            
            button.frame = CGRectMake(btnWidth, 0, 80, 49)
            
            button.tag = index+100
            
            let title = self.itemArray[index]
            
             button.setTitle(title, forState: .Normal)
            
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            
            button.setTitleColor(tabBarBGColor, forState: .Selected)
            
            button.addTarget(self, action: "tabBarButtonClicked:", forControlEvents: .TouchUpInside)
            
            self.myTabBar?.addSubview(button)
            
            if index == 0 {
                
                button.selected = true
            
            }
        
        }
    }
    
    func initViewController() {
        
        let vc1 = JYJokeTableViewController()
        
        vc1.jokeType = .NewsJoke
        
        let vc2 = JYJokeTableViewController()
        
        vc2.jokeType = .HotJoke
        
        let vc3 = JYJokeTableViewController()
        
        vc3.jokeType = .ImageTruth
        
        let vc4 = JYAboutViewController(nibName: "JYAboutViewController", bundle: nil)
        
        self.viewControllers = [vc1, vc2, vc3, vc4]
    
    }
    
    func tabBarButtonClicked(sender: UIButton) {
        
        let index = sender.tag
        
        for var i = 0; i < 4; i++ {
            
            let button = self.view.viewWithTag(i + 100) as! UIButton
            
            if button.tag == index {
                
                button.selected = true
            
            } else {
                
                button.selected = false
            
            }
            
            UIView.animateWithDuration( 0.3, animations: {
                
                self.slider?.frame = CGRectMake(CGFloat(index - 100) * 80, 0, 80, 49)
            
            })
            
            self.title = itemArray[index - 100] as String
            
            self.selectedIndex = index - 100
        
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
