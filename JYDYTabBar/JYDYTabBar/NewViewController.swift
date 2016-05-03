//
//  NewViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import MJRefresh

class NewViewController: UIViewController {

    /*var jytableView: UITableView?
    
    var maxTime: String?
    
    var jyTopics: [JYTopics]? {
        
        didSet {
            
            
            self.jyTableView.reloadData()
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUIS()
        
        addRefresh()
        
        
        
    }
    
    
    private func setupUIS() {
        
        jytableView = jyTableView
        
        self.view.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(jyTableView)
        
        let width = UIScreen.mainScreen().bounds.width
        
        let height = UIScreen.mainScreen().bounds.height
        
        jyTableView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: CGSize(width: width, height: height), offset: CGPoint(x: 0, y: 0))
        
        
        
        jyTableView.contentInset = UIEdgeInsets(top: 35, left: 0, bottom: self.tabBarController!.tabBar.frame.height, right: 0)
        
        
        
        jyTableView.scrollIndicatorInsets = jyTableView.contentInset
    }
    
    private func addRefresh() {
        
        let header = MJRefreshNormalHeader()
        
        let footer = MJRefreshBackNormalFooter()
        
        header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadNextPageData))
    
        self.jyTableView.mj_header = header
        
        self.jyTableView.mj_footer = footer
        
        self.jyTableView.mj_header.automaticallyChangeAlpha = true
        
        self.jyTableView.mj_header.beginRefreshing()
        

    }
    
    func loadNewData() {
        
        BudejieNetTool.loadHomeData("0", maxtime: nil, ) { (jyTopic, jyTopicInfo , error) in
            
            if jyTopic != nil && error == nil && jyTopicInfo != nil {
                
                self.jyTopics = jyTopic
                
                self.maxTime = jyTopicInfo!.maxtime
                
                self.jyTableView.mj_header.endRefreshing()
            }
            
        }
    
    }
    
    func loadNextPageData() {
        
        BudejieNetTool.loadHomeData("1", maxtime: self.maxTime) { (jyTopic, jyTopicInfo , error) in
            
            if jyTopic != nil && error == nil && jyTopicInfo != nil {
                
                let loadCount = jyTopic!.count - self.jyTopics!.count
                
                self.jyTopics = self.jyTopics! + jyTopic!
                
                //self.jyTableView.reloadData()
                
                self.jyTableView.mj_footer.endRefreshing()
                
                self.maxTime = jyTopicInfo!.maxtime
            }
            
        }
    
    }
    
    private lazy var jyTableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.registerClass(JYTopicCell.self, forCellReuseIdentifier: AllReuseIdentifier)
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        return tableView
        
        
    }()

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

extension NewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jyTopics?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(AllReuseIdentifier, forIndexPath: indexPath) as! JYTopicCell
        
        let topoic = self.jyTopics![indexPath.row]
        
        cell.topic = topoic
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(AllReuseIdentifier) as! JYTopicCell
        
        let topic = self.jyTopics![indexPath.row]
        
        let rowheight = cell.getRowHeight(topic)
        
        return rowheight
    }
    */
}
