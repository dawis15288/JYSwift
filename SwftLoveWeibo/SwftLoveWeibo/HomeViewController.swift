//
//  HomeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    @IBOutlet weak var singinButton: UIButton!
    
    var refreshViewController = UIRefreshControl()
    
    var tableData = [JSON]()
    
    var weiboData: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        checkForExistingAccessToken()

        // Do any additional setup after loading the view.
        
        let JYCell = UINib(nibName: "JYTableViewCell", bundle: nil)
        
        setupNavgationItem()
        
        tableView.registerNib(JYCell, forCellReuseIdentifier: "JYCell")
        
        self.refreshViewController.addTarget(self, action: "loadNewWeibo", forControlEvents: .ValueChanged)
        
        let attributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        
        self.refreshViewController.attributedTitle = NSAttributedString(string: "Last updated on \(NSDate())", attributes: attributes)
        
        
        self.tableView.addSubview(refreshViewController)
        
        self.refreshViewController.beginRefreshing()
        
    }
    
    func loadNewWeibo() {
        
        print("loadNewWeibo")
        
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
        
        print(__FUNCTION__)
        
        
    }
    
    func rightBtnClick(sender: UIBarButtonItem) {
        
        
        
        //print(sender)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("QRCodeViewController")
        
        let navVC = UINavigationController(rootViewController: vc)
        
        navVC.navigationBar.barTintColor = UIColor.blackColor()
        
        presentViewController(navVC, animated: true, completion: { [unowned self] () -> Void in
        
            
        })
        
        //sender.selected = !sender.selected
        
        /*let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddFrend")
        
        vc.modalPresentationStyle  = .Popover
        
        if let popover = vc.popoverPresentationController {
        
            popover.delegate = self
            
            popover.sourceView = vc.view
            
            //364 7; 30 30
            
            let rect = navigationController?.navigationBar.frame
            
            print(rect)
            
            popover.sourceRect =
            
            popover.permittedArrowDirections = .Up
        }
        
        vc.preferredContentSize = CGSize(width: 200, height: 100)
        
        presentViewController(vc, animated: true, completion: { () -> Void in
            
            vc.view.backgroundColor = UIColor.grayColor()
        
        })*/
        
    }
    
    func dismiss(sender: UIBarButtonItem) {}
    
    func imagePicker(sender: UIBarButtonItem) {}
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
        
    }
    
    func titleBtnClick(sender: UIButton) {
        
        print(sender)
        
        sender.selected = !sender.selected
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FriendGroup")
        
        //let sb = UIStoryboard(name: "FriendGroup", bundle: nil)
        
        //let vc = sb.instantiateInitialViewController()!
        
        //vc.transitioningDelegate = self
        
        vc.modalPresentationStyle = .Custom
        
        presentViewController(vc, animated: true, completion: nil)
    
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
            
            //singinButton.enabled = false
            
            //singinButton.hidden = true
            
            //weiboAccessToken
            
            let weiboAccessToken = NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") as! String
            
            //weiboData = WeiboModal().getWeiboData(3, weiboAccessToken: weiboAccessToken)
            
            print(weiboAccessToken)
            
            WeiboModal().getWeiboData(3, weiboAccessToken: weiboAccessToken, completionHandler: { (data) -> Void in
                
                
               //self.tableData.append(data)这样就很方便的转换成数组，以前不知道！
                
                self.tableData = data.arrayValue
                
                
                
                /*for var i = 0; i < data.count; i++ {
                    
                    self.tableData.append(data[i])
                    
                }*/
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.tableView.reloadData()
                
                })
                
            })
            
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JYCell", forIndexPath: indexPath) as! JYTableViewCell
            
        let cellData = tableData[indexPath.row]
        
        cell.namelabel.attributedText = makeNameAttributedString(title: "\(cellData["user"]["name"])")
        
        cell.contentLabel.attributedText = makeTitleAttributedString(title: "\(cellData["text"])")
        
        let annotations = cellData["annotations"].arrayValue
        
        if annotations.count != 0 {
            
            if annotations[0]["client_mblogid"] != nil {
            
                print("cellData ----->> \(annotations[0]["client_mblogid"])")
                
                cell.clentLabel.text =  "来自\(annotations[0]["client_mblogid"])"
                
            } else {
                
                cell.clentLabel.text = "来自weibo"
            
            }
            
            
        
        }
        
        cell.timeLabel.text = "\(cellData["created_at"])"
        
        cell.headrImg.setWebImage("\(cellData["user"]["avatar_large"])")
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func makeTitleAttributedString(title title: String) -> NSAttributedString {
        
        
        
        let subTitleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        
        
        
        let subTitleString = NSMutableAttributedString(string: title, attributes: subTitleAttributes)
        
        
        return subTitleString
    
    }
    
    func makeNameAttributedString(title title: String) -> NSAttributedString {
        
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), NSForegroundColorAttributeName: UIColor.purpleColor()]
        
        let titleString = NSMutableAttributedString(string: title, attributes: titleAttributes)
        
        return titleString
    
    }
    
    var isPresent = false
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate{
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        return .None
    }

    /*func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return PopoverPresentationControllr(presentedViewController: presented, presentingViewController: presenting)
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = true
        
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = false
        
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    /**
    返回动画时长
    
    :param: transitionContext 转场上下文, 提供了转场需要的参数
    
    :returns: 动画时长
    */
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.5
    }
    
    /**
    转场动画实现函数, 一旦实现这个方法默认的转场动画会失效, 一切都由程序员提供
    
    :param: transitionContext 转场上下文, 提供了转场需要的参数
    */
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        print(toVc)
        
        print(fromVc)
        
        if isPresent {
            
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            transitionContext.containerView()?.addSubview(toView)
            
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            
            toView.layer.anchorPoint = CGPoint(x: 0.8, y: 0)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
            
                toView.transform = CGAffineTransformIdentity
                
                }) { (finish) -> Void in
                    
                    // 一定要告诉系统转场动画结束
                    
                    transitionContext.completeTransition(true)
            
            }
        
        } else {
        
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.00001)
            
                }, completion: { (finish) -> Void in
            
                    fromView?.removeFromSuperview()
                    
                    transitionContext.completeTransition(true)
            })
        
        }
    }*/

}
