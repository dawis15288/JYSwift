//
//  HomCategroy.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit


extension HomeViewController {
    
    // MARK: tablView data delegate
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    return 1
    }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statues?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(JYHomeCellReuseIdentifier, forIndexPath: indexPath) as! StatusTableViewCell
        
        let status = statues![indexPath.row]
        
        cell.status = status
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let status = statues![indexPath.row]
        
        if let height =  rowheightCache[status.id] {
            
            return height
            
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(JYHomeCellReuseIdentifier) as! StatusTableViewCell
        
        let rowHeight = cell.rowHeight(status)
        
        rowheightCache[status.id] = rowHeight
        
        return rowHeight
        
    }
    
    
    
}