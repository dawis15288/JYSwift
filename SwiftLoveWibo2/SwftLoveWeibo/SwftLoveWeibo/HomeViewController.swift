//
//  HomeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

// 先设置成全局变量

let JYPopoverAnimatorWillShowNotification = "XMGPopoverAnimatorShowNotification"

let JYPopoverAnimatorWillDismissNotification = "XMGPopoverAnimatorDismissNotification"

let JYHomeCellReuseIdentifier = "JYHomeCellRuseIdentifier"


var rowheightCache: [Int: CGFloat] = [Int: CGFloat]()

class HomeViewController: BaseViewController {
    
    var titles: String?
    
    var statues: [Status]? {
        
        didSet {
        
            tableView.reloadData()
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !login {
            
            visitorView?.setupVisitorInfo(true, imagename: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            
            return
        
        }
            
            setupNavgationItem()
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "change:", name: JYPopoverAnimatorWillShowNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "change:", name: JYPopoverAnimatorWillDismissNotification, object: nil)
            
            //注册cell
            
            tableView.registerClass(StatusTableViewCell.self, forCellReuseIdentifier: JYHomeCellReuseIdentifier)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            //tableView.rowHeight = 300
            
            //tableView.estimatedRowHeight = 200
            
            //tableView.rowHeight = UITableViewAutomaticDimension
            //因为这里没有设置所以界面变得什么鬼！
            //tableView.rowHeight = 300
            
            
            
            loadData()
        
        
        
        
    }
    
    // MARK:  获取微博数
    
    func loadData() {
        
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
        
            Status.loadStatuses(3, weiboAccessToken: weiboAccessToken, completeionHandler: { (status, error) -> Void in
                
                if status != nil && error == nil {
                    
                    self.statues = status
                
                }
            
            })
        }
    
        
    }
    
    // MARK:  改变导航栏标题视图状态
    
    func change(notification: NSNotification) {
        
        print("titileBtn 打开或者关闭！")
    
        let titleBTn = navigationItem.titleView as! TitleButton
        
        titleBTn.selected = !titleBTn.selected
        
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    
    // MARK: 设置home视图的导航条
    private func setupNavgationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_friendattention", target: self, action: "leftBtnClick:")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_pop", target: self, action: "rightBtnClick:")
        
        let titleBtn = TitleButton()
        
        print(" bant把标题按耨的辩题是 \(titleBtn))")
        
        //titleBtn.setTitle("\(gname)", forState: .Normal)
        
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = titleBtn
    
    }
    
    func leftBtnClick(sender: UIBarButtonItem) {
        
        
        
        
    }
    
    func rightBtnClick(sender: UIBarButtonItem) {
        
        if login {
            
            let sb = UIStoryboard(name: "Scan", bundle: nil)
            
            // 必须设置 is initial view controller 要不就找不到视图控制器
            
            if let vc = sb.instantiateInitialViewController() {
                
                print(vc.view)
                
                vc.transitioningDelegate = popoverAnimation
                
                popoverAnimation.presentFrame = CGRect(x:320, y: 60, width: 85, height: 90)
                
                vc.modalPresentationStyle = .Custom
                
                presentViewController(vc, animated: true, completion: nil)
                
            }
        
        }
        
        
        
    }
    
    func titleBtnClick(sender: UIButton) {
        
        if login {
            
            let  sb = UIStoryboard(name: "Popover", bundle: nil)
            
            let popoverViewController = sb.instantiateInitialViewController()
            
            popoverViewController?.transitioningDelegate = popoverAnimation
            
            popoverAnimation.presentFrame = CGRect(x: 140, y: 60, width: 140, height: 190)
            
            popoverViewController?.modalPresentationStyle = .Custom
            
            presentViewController(popoverViewController!, animated: true, completion: nil)
        
        }
    }
    
    
    private lazy var popoverAnimation: PopoverAnimation = {
    
        let pa = PopoverAnimation()
        
        return pa
        
    }()
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        rowheightCache.removeAll()
        
    }
    
    
 

}


