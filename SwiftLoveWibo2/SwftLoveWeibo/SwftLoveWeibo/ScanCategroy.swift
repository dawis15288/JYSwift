//
//  ScanCategroy.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension ScanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
        
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            let sCanVC = sb.instantiateViewControllerWithIdentifier("SCanNav")
            
            presentViewController(sCanVC, animated: true, completion: nil)
        }
    }
    
}