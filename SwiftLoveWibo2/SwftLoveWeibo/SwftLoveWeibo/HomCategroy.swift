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
        
        let status = statues![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatuTableViewCellReuseIdentifier.cellID(status), forIndexPath: indexPath) as! StatusTableViewCell
        
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
            
            weiboNetWorkTool.loadComments(weiboAccessToken, webId: status.id, completedhandler: { (modules, error) in
                
                if modules != nil && error == nil {
                    
                        status.comments = modules
                    
                    }
                
                
                })
            
            
        }
        
        
        
        cell.status = status
        
        if indexPath.row == (statues?.count)! - 1 {
            
            pullRefreshFlag = true
            
            loadData()
        
        }
        
        
        return cell
    }
    
   
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
         let status = statues![indexPath.row]
        
        if let height = rowheightCache[status.id] {
            
            return height
        
        }
            
        let cell = tableView.dequeueReusableCellWithIdentifier(StatuTableViewCellReuseIdentifier.cellID(status)) as! StatusTableViewCell
        
        let rowHeight = cell.rowHeights(status)
        
        rowheightCache[status.id] = rowHeight
        
        return rowHeight
           
    }
    
    
}