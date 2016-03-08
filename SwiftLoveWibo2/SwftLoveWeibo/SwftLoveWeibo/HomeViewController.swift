//
//  HomeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

let JYPopoverAnimatorShowNotification = "XMGPopoverAnimatorShowNotification"
let JYPopoverAnimatorDismissNotification = "XMGPopoverAnimatorDismissNotification"

let JYHomeCellReuseIdentifier = "JYHomeCellRuseIdentifier"

class HomeViewController: BaseViewController, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var singinButton: UIButton!
    
    var refreshViewController = UIRefreshControl()
    
    var tableData = [JSON]()
    
    var weiboData: AnyObject?
    
    var statues: [Status]? {
        
        didSet {
        
            tableView.reloadData()
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !login {
            
            visitorView?.setupVisitorInfo(true, imagename: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
        
        } else {
            
            setupNavgationItem()
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorShowNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorDismissNotification, object: nil)
            
            //注册cell
            
            tableView.registerClass(StatusTableViewCell.self, forCellReuseIdentifier: JYHomeCellReuseIdentifier)
            
            tableView.estimatedRowHeight = 200
            
            tableView.rowHeight = UITableViewAutomaticDimension
            
            loadData()
        
        }
        
        
        
        
    }
    
    // MARK:  获取微博数
    
    func loadData() {
        
        print("开始联网获取微博数据")
        
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
        
            Status.loadStatuses(3, weiboAccessToken: weiboAccessToken, completeionHandler: { (status, error) -> Void in
                
                if status != nil && error == nil {
                    
                    //print("已经获取到微博数据\(self.statues![0].text)\n\n\n")
                    
                    self.statues = status
                
                }
            
            })
        }
    
        
    }
    
    // MARK:  改变导航栏标题视图状态
    
    func change() {
    
        let titleBTn = navigationItem.titleView as! TitleButton
        
        titleBTn.selected = !titleBTn.selected
        
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loadNewWeibo() {
        
        checkForExistingAccessToken()
        
        self.refreshViewController.endRefreshing()
    
    }
    
    
    
    private func setupNavgationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_friendattention", target: self, action: "leftBtnClick:")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_pop", target: self, action: "rightBtnClick:")
        
        let titleBtn = TitleButton()
        
        titleBtn.setTitle("JYProject", forState: UIControlState.Normal)
        
        titleBtn.sizeToFit()
        
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = titleBtn
    
    }
    
    func leftBtnClick(sender: UIBarButtonItem) {
        
        
        
        
    }
    
    func rightBtnClick(sender: UIBarButtonItem) {
        
        let jyPopoverVC = JYPopoverViewController()
        
        jyPopoverVC.modalPresentationStyle = .Popover
        
        jyPopoverVC.preferredContentSize = CGSizeMake(80, 100)
        
        if let popover = jyPopoverVC.popoverPresentationController {
            
            popover.delegate = self
            
            popover.barButtonItem = navigationItem.rightBarButtonItem
            
            popover.permittedArrowDirections = .Any
        
        }
        
        
        
        presentViewController(jyPopoverVC, animated: true, completion: { () -> Void in
            
            jyPopoverVC.view.backgroundColor = UIColor.grayColor()
            
            let frame1 = CGRectMake(10, 10, 60, 10)
            
            let label1 = UILabel(frame: frame1)
            
            label1.text = "label1"
            
            let frame2 = CGRectMake(10, 25, 60, 10)
            
            let label2 = UILabel(frame: frame2)
            
            label2.text = "label2"
            
            jyPopoverVC.view.addSubview(label1)
            
            jyPopoverVC.view.addSubview(label2)
        
        })
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
        
    }
    
    func titleBtnClick(sender: UIButton) {
        
        let jyPopoverVC = JYPopoverViewController()
        
        jyPopoverVC.modalPresentationStyle = .Popover
        
        jyPopoverVC.preferredContentSize = CGSizeMake(80, 100)
        
        if let popover = jyPopoverVC.popoverPresentationController {
            
            popover.delegate = self
            
            popover.sourceView = navigationItem.titleView
            
           popover.sourceRect = CGRectMake(10, 10, 80, 100)
            
            //popover.barButtonItem = navigationItem.leftBarButtonItem
            
            
            popover.permittedArrowDirections = .Up
            
        }
        
        
        
        presentViewController(jyPopoverVC, animated: true, completion: { () -> Void in
            
           /* jyPopoverVC.view.backgroundColor = UIColor.grayColor()
            
            let frame1 = CGRectMake(10, 10, 60, 10)
            
            let label1 = UILabel(frame: frame1)
            
            label1.text = "label1"
            
            let frame2 = CGRectMake(10, 25, 60, 10)
            
            let label2 = UILabel(frame: frame2)
            
            label2.text = "label2"
            
            jyPopoverVC.view.addSubview(label1)
            
            jyPopoverVC.view.addSubview(label2)*/
            
        })
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForExistingAccessToken() {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") != nil {
            
            
            let weiboAccessToken = NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") as! String
            
            WeiboModal().getWeiboData(3, weiboAccessToken: weiboAccessToken, completionHandler: { (data) -> Void in
                
                
               //self.tableData.append(data)这样就很方便的转换成数组，以前不知道！
                
                self.tableData = data.arrayValue
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.tableView.reloadData()
                
                })
                
            })
            
        }
        
    }
    
    
 

}

extension HomeViewController {
    
    // MARK: tablView data delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statues?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(JYHomeCellReuseIdentifier, forIndexPath: indexPath) as! StatusTableViewCell
        
        let status = statues![indexPath.row]
        
        print("获取到的微博数据\(status.source)\n\n\n")
        
        cell.status = status
        
        
        return cell
    }

}
