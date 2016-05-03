//
//  MainTagSubViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

let JYMainTagSubIdentifier = "JYMainTagSubCell"

class MainTagSubViewController: UITableViewController {
    
    
    
    var recommenData: [Recommends]? {
        
        didSet {
            
            tableView.reloadData()
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.registerClass(JYRecommenCell.self, forCellReuseIdentifier: JYMainTagSubIdentifier)
        
        tableView.backgroundColor = UIColor.grayColor()
        
        tableView.frame.origin.x = 10
        
        tableView.rowHeight = 88
        
        BudejieNetTool.RecommendData { (recommens, errr) in
            
            if recommens != nil && errr == nil {
            
                self.recommenData = recommens
            }
            
        }
        
    }

}

extension MainTagSubViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommenData?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier(JYMainTagSubIdentifier, forIndexPath: indexPath) as! JYRecommenCell
        
        
        
        let rec = self.recommenData![indexPath.row]
        
        cell.recmmen = rec
        
        return cell
    
    }
}
