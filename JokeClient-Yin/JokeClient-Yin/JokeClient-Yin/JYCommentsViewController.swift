//
//  JYCommentsViewController.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, JYRefreshViewDelegate {
    
    let cellID = "CommentCell"
    //CommentCell
    
    var jokeType: JYJokeTableViewControllerType = .HotJoke
    
    var tableView: UITableView?
    
    var dataArray: [Comments]?
    
    var page: Int = 1
    
    var refreshView: JYRefreshViewController?
    
    var jokeId: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "评论"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        setupViews()
        
        loadData()
        
        
    }
    
    func setupViews() {
        
        let width = self.view.frame.size.width
        
        let height = self.view.frame.size.height
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, width, height), style: .Plain)
        
        self.tableView?.delegate = self
        
        self.tableView?.dataSource = self
        
        self.tableView?.separatorStyle = .None
        
        let cellNib = UINib(nibName: "JYCommentCell", bundle: nil)
        
        self.tableView?.registerNib(cellNib, forCellReuseIdentifier: cellID)
        
        var arr = NSBundle.mainBundle().loadNibNamed("JYRefreshView", owner: self, options: nil)
        
        self.refreshView = arr[0] as? JYRefreshViewController
        
        self.refreshView?.delegate = self
        
        self.tableView?.tableFooterView = self.refreshView
        
        self.tableView?.tableHeaderView
        
        
        
        self.view.addSubview(self.tableView!)
    
    }
    
    func loadData() {
        
        let url = "http://m2.qiushibaike.com/article/\(self.jokeId!)/comments?count=20&page=\(self.page)"
        
        self.refreshView?.startLoadng()
        
        JYHttprRequest.requestWithURL(url, completionHandler: { data in
            
            
            if data == nil {
                
                self.presentViewController(UIView.showAlertView("提示", message: "加载失败！"), animated: true, completion: { () -> Void in
                    
                    print("ok")
                
                })
                
                return
            
            }
            
            if let arr = data {
            
                self.dataArray = Comments.model2comment(arr)
                
            }
            
            if self.dataArray!.count == 0 {
                
                self.presentViewController(UIView.showAlertView("提示", message: "暂是没有新评论！"), animated: true, completion: { () -> Void in
                    
                    print("ok")
                    
                })
                
                self.tableView?.tableFooterView = nil
            
            }
            
            self.tableView?.reloadData()
            
            self.refreshView?.stopLoading()
            
            self.page += self.page
        
        })
    
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? JYCommentCell
        
        let index = indexPath.row
        
        let data = self.dataArray![index]
        
        cell!.data = data
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let index = indexPath.row
        
        let data = self.dataArray![index]
        
        return JYCommentCell.cellHeightByData(data)
    }
    
    func refreshView(refreshView: JYRefreshViewController, didClickButton btn: UIButton) {
        print("refresh")
        loadData()
        
        
    }
}
