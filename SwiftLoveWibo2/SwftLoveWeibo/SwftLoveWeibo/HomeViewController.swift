//
//  HomeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SVProgressHUD

// 先设置成全局变量

let mainScreenWidth = UIScreen.mainScreen().bounds.width

let JYPopoverAnimatorWillShowNotification = "XMGPopoverAnimatorShowNotification"

let JYPopoverAnimatorWillDismissNotification = "XMGPopoverAnimatorDismissNotification"

let JYHomeCellReuseIdentifier = "JYHomeCellRuseIdentifier"

let JYNomalCellReuseIdentifier = "JYNomalCellRuseIdentifier"

var rowheightCache: [Int: CGFloat] = [Int: CGFloat]()

enum StatuTableViewCellReuseIdentifier: String {

    case NomalCell = "NomalCell"
    
    case ForwardCell = "ForwardCell"
    
    static func cellID(status: Status?) -> String {
    
        return status!.retweeted_Status != nil ? ForwardCell.rawValue: NomalCell.rawValue
    }
}

class HomeViewController: BaseViewController {
    
    var titles: String?
    
    var refresh: HomeRefreshControl?
    
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
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(change), name: JYPopoverAnimatorWillShowNotification, object: nil)
            
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(change), name: JYPopoverAnimatorWillDismissNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showWeiboPictrue), name: JYShowWeiboPictrue, object: nil)
            
            //注册cell
            
            tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: StatuTableViewCellReuseIdentifier.NomalCell.rawValue)
            
           tableView.registerClass(StatusForwardCell.self, forCellReuseIdentifier: StatuTableViewCellReuseIdentifier.ForwardCell.rawValue)
            
           //tableView.rowHeight = 300
            
        
            
            //tableView.rowHeight = UITableViewAutomaticDimension
        
            //tableView.estimatedRowHeight = 200
        
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            //因为这里没有设置所以界面变得什么鬼！
            //tableView.rowHeight = 300
            
            refreshControl = HomeRefreshControl()
        
           refreshControl?.beginRefreshing()
        
        refreshControl?.addTarget(self, action: #selector(loadData), forControlEvents: .ValueChanged)
        
        
            
            loadData()
 
    }
    
    func showWeiboPictrue(notification: NSNotification) {
    
        if let pictrueIndex = notification.userInfo![JYShowWeiboPictrueIndex], pictrueURLs = notification.userInfo![JYShowWeiboPictrueURLs] as? [NSURL] {
            
            let pictrueVC = WeiboPictrueViewController(index: pictrueIndex.item, imageURL: pictrueURLs)
            
            //let indexPath = NSIndexPath(forItem: pictrueIndex.item, inSection: 0)
            
            presentViewController(pictrueVC, animated: true, completion: { () -> Void in
                
               /* pictrueVC.pictrueCollectionView.scrollToItemAtIndexPath(indexPath
                  , atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)*/
            
            })
        
        }
    }
    
    // MARK:  获取微博数
    
    var pullRefreshFlag = false
    
    func loadData() {
        
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
            
            var since_id = statues?.first?.id ?? 0
            
            var max_id = 0
            
            if pullRefreshFlag {
                
                since_id = 0
                
                max_id = statues?.last?.id ?? 0
            
            }
            
            
            
            weiboNetWorkTool.loadStatuses(since_id, max_id: max_id, weiboAccessToken: weiboAccessToken, completeionHandler: { (status, error) in
                
                
                if status != nil && error == nil {
                    
                    self.refreshControl?.endRefreshing()
                    
                    if since_id > 0{
                        
                        self.shwNewStatusLabel(status!.count)
                        
                        self.statues = status! + self.statues!
                        
                        
                    } else if max_id > 0 {
                        
                        self.statues = self.statues! + status!
                        
                        self.pullRefreshFlag = false
                        
                    } else {
                        
                        self.statues = status
                    }
                    
                    
                    
                } else {
                    
                    
                    
                    self.refreshControl?.endRefreshing()
                    
                    let ac = UIAlertController(title: "网路提示", message: "\(error!.localizedDescription)\n请检查网络是否畅通", preferredStyle: .Alert)
                    
                    ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                    
                    self.presentViewController(ac, animated: true, completion: nil)
                    
                    
                }
            })
   
        
            /*Status.loadStatuses(since_id, max_id:max_id ,weiboAccessToken: weiboAccessToken, completeionHandler: { (status, error) -> Void in
                
                if status != nil && error == nil {
                    
                    self.refreshControl?.endRefreshing()
                    
                    if since_id > 0{
                        
                        self.shwNewStatusLabel(status!.count)
                        
                        self.statues = status! + self.statues!
    
                    
                    } else if max_id > 0 {
                    
                        self.statues = self.statues! + status!
                        
                        self.pullRefreshFlag = false
                    
                    } else {
                    
                        self.statues = status
                    }
                    
                    
                
                } else {
                    
                    
                    
                    self.refreshControl?.endRefreshing()
                
                    let ac = UIAlertController(title: "网路提示", message: "\(error!.localizedDescription)\n请检查网络是否畅通", preferredStyle: .Alert)
                    
                    ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                    
                    self.presentViewController(ac, animated: true, completion: nil)
                    
                    
                }
            
            })*/
        }
    
        
    }
    
    // MARK:  改变导航栏标题视图状态
    
    private func shwNewStatusLabel(count: Int) {
        
        newStatusLabel.text = (count == 0) ? "暂时没有新的微博" : "刷新到\(count)条新微薄"
        
        newStatusLabel.hidden = false
        
        
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            
            //self.newStatusLabel.frame = CGRectOffset(rect, 0, 3 * rect.height)
            
            self.newStatusLabel.transform = CGAffineTransformMakeTranslation(0, self.newStatusLabel.frame.height)
            
            }, completion: { (finished) -> Void in
        
                //self.newStatusLabel.frame = rect
                
                UIView.animateWithDuration(2, animations: { () -> Void in
                    
                        self.newStatusLabel.transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                
                        self.newStatusLabel.hidden = true
                })
        })
    
    }
    
    // MARK:  改变导航栏标题视图状态
    
    func change(notification: NSNotification) {
    
        let titleBTn = navigationItem.titleView as! TitleButton
        
        titleBTn.selected = !titleBTn.selected
        
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    
    // MARK: 设置home视图的导航条
    private func setupNavgationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_friendattention", target: self, action: #selector(leftBtnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_pop", target: self, action: #selector(rightBtnClick))
        
        let titleBtn = TitleButton()
        
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = titleBtn
    
    }
    
    func leftBtnClick(sender: UIBarButtonItem) {
        
        
        
        
    }
    //MARK: 扫一扫功能
    func rightBtnClick(sender: UIBarButtonItem) {
        
        print("__+++_____++\(tableView.frame.origin.y)+_____++++____")
        
        if login {
            
            let sb = UIStoryboard(name: "Scan", bundle: nil)
            
            // 必须设置 is initial view controller 要不就找不到视图控制器
            
            if let vc = sb.instantiateInitialViewController() {
                
                vc.transitioningDelegate = popoverAnimation
                
                let width: CGFloat = 85.0
                
                let x  = mainScreenWidth - width - 5
                
                popoverAnimation.presentFrame = CGRect(x: x, y: 59, width: width, height: 90)
                
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
            
            let width:CGFloat = 145
            
            let x = ( mainScreenWidth - width ) * 0.5
            
            popoverAnimation.presentFrame = CGRect(x: x, y: 59, width: width, height: 190)
            
            popoverViewController?.modalPresentationStyle = .Custom
            
            presentViewController(popoverViewController!, animated: true, completion: nil)
        
        }
    }
    
    
    private lazy var popoverAnimation: PopoverAnimation = {
    
        let pa = PopoverAnimation()
        
        return pa
        
    }()
    
    private lazy var newStatusLabel: UILabel = {
        
        let label = UILabel()
        
        label.backgroundColor = UIColor.orangeColor()
        
        label.textAlignment = .Center
        
        label.font = UIFont.systemFontOfSize(14)
        
        label.textColor = UIColor.whiteColor()
        
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44)
        
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        
        label.hidden = true
        
        return label
        
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


