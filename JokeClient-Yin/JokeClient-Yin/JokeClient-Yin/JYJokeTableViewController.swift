//
//  JYJokeTableViewController.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

enum JYJokeTableViewControllerType: Int {
    
    case HotJoke
    
    case NewsJoke
    
    case ImageTruth


}

class JYJokeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, JYRefreshViewDelegate, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate {
    
    let identifier = "CYJokeCellIdentifier"
    //JYJokeCellID
    
    var jokeType: JYJokeTableViewControllerType = .HotJoke
    
    var tableView: UITableView?
    
    
    var dataArray = NSMutableArray()
    
    var page: Int = 1
    
    var refreshView: JYRefreshViewController?
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //imageViewTapped
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewTapped:", name: "imageViewTapped", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "imageViewTapped", object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        
        loadData()
    }
    
    func setupViews() {
        
        let width = self.view.frame.size.width
        
        let height = self.view.frame.size.height
        
        self.tableView = UITableView(frame: CGRectMake(0, 64, width, height-49-64))
        
        self.tableView?.dataSource = self
        
        self.tableView?.delegate = self
        
        self.tableView?.separatorStyle = .None
        
        let nib = UINib(nibName: "CYTableViewCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        
        //JYRefreshView
        
        var arr = NSBundle.mainBundle().loadNibNamed("JYRefreshView", owner: self, options: nil) as Array
        
        self.refreshView = arr[0] as? JYRefreshViewController
        
        self.refreshView?.delegate = self
        
        self.tableView?.tableFooterView = self.refreshView
        
        self.view.addSubview(self.tableView!)
    
    }
    
    func loadData() {
        
        let url = urlString()
        
        self.refreshView?.startLoadng()
        
        //let fadeURL = "http://jyproject.com"
        
        JYHttprRequest.requestWithURL(url, completionHandler: { data in
            
            //print(data)
        
            if data as! NSObject == NSNull() {
                
                self.presentViewController(UIView.showAlertView("提示", message: "加载失败"), animated: true, completion: { () -> Void in
                    
                    print("ok")
                
                })
                
                return
            
            }
            
            let arr = data["items"] as! NSArray
            
            for data: AnyObject in arr {
                
                self.dataArray.addObject(data)
            
            }
            
            self.tableView?.reloadData()
            
            self.refreshView?.stopLoading()
            
            self.page++
        
        })
        
        
    
    }
    
    func urlString() -> String {
        
        if jokeType == .HotJoke {
        
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        
        }
        
        else if jokeType == .NewsJoke {
            
            return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
        
        
        }
        
        else {
        
            return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        
        }
    
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? CYTableViewCell
        
        if (cell == nil) {
            
            cell = CYTableViewCell()
        
        }
        
        let index = indexPath.row
        
        let data = self.dataArray[index] as! NSDictionary
        
        cell!.data = data
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let index = indexPath.row
        
        let data = self.dataArray[index] as! NSDictionary
        
        return CYTableViewCell.cellheightByData(data)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let index = indexPath.row
        
        let data = self.dataArray[index] as! NSDictionary
        
        let commentsVc = JYCommentsViewController()
        
        commentsVc.jokeId = data.stringAttributeForkey("id")
        
        self.navigationController?.pushViewController(commentsVc, animated: true)
        
        
    }
    
    func refreshView(refreshView: JYRefreshViewController, didClickButton btn: UIButton) {
        
        loadData()
    }
    
    func imageViewTapped(notification: NSNotification) {
        
        let imageURL = notification.object as! String
        
        //print(imageURL)
        
        let popoverVC = JYImageViewController(nibName: nil, bundle: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissBifImage")
        
        popoverVC.view.addGestureRecognizer(tap)
        
        popoverVC.modalPresentationStyle = .Popover
        
        if let popover = popoverVC.popoverPresentationController {
            
            popover.delegate = self
            
            popover.sourceView = self.view
            
            popover.sourceRect = CGRectMake(0, 0, 320, 640)
            
            
        
        }
        
        let imageView = UIImageView(frame: popoverVC.view.frame)
        
        imageView.setImage(imageURL, placeHolder: nil)
        
        imageView.contentMode = .ScaleAspectFit
        
        
        presentViewController(popoverVC, animated: true, completion: { () -> Void in
           
            
            
            popoverVC.view.addSubview(imageView)
            
            print(" -------> popoverVc <----------")
        
        })
        
    
    }
    
    func dismissBifImage() {
        
        print("big Image")
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    /*func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
        
    }*/
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        print("scrollViewWillEndDragging")
        
        //loadData()
        
        self.tableView?.tableHeaderView = self.refreshView
        
        loadData()    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
        print("scrollViewDidScrollToTop")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
