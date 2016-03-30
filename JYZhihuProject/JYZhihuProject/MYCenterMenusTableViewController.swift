//
//  MYCenterMenusTableViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class MYCenterMenusTableViewController: UITableViewController {
    var menuArray: [MenuModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuData = NSUserDefaults.standardUserDefaults().objectForKey(Keys.MyCenterMenuArrayKey)
        
        if menuData == nil {
            
            let array: [MenuModel] = []
            
            NSUserDefaults.standardUserDefaults().setObject(array, forKey: Keys.MyCenterMenuArrayKey)
            
        } else {
            
            if let data = menuData as? NSData {
            
                self.menuArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [MenuModel]
                
            }
            
            
            
        }
        
        getMenuData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getMenuData() {
        
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/themes").responseJSON(completionHandler: { [ unowned self ](response) -> Void in
            
            print("\(response.result)")
            
            guard response.result.error == nil else {
                
                print("加载失败")
                
                return
            }
            
            self.menuArray = []
            
            if let data =  response.data {
                
                let data = JSON(data: data)["others"]
                
                //print(data)
                
                for i in 0 ..< data.count {
                    
                    let dataModel = MenuModel(id: String(data[i]["id"]), name: data[i]["name"].string!)
                    
                    self.menuArray.append(dataModel)
                    
                }
                
                let menuArrayData = NSKeyedArchiver.archivedDataWithRootObject(self.menuArray)
                
                NSUserDefaults.standardUserDefaults().setObject(menuArrayData, forKey: "MyCenterMenuArrayKey")
                
                self.tableView.reloadData()
                
            }
            
            
            
            
            
            
            })
    
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuArray.count + 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath)
            
            return cell
        
        }
        
        else if indexPath.row == 1 + self.menuArray.count {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("spaceCell", forIndexPath: indexPath)
            
            return cell
        
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("subCell", forIndexPath: indexPath)
            
            if let label = cell.contentView.viewWithTag(1) as? UILabel {
                
                let dataModl = self.menuArray[ indexPath.row - 1] as MenuModel
                
                print("\(dataModl.MenuName) -- \(indexPath)---\(self.menuArray.count)")
                    
                label.text = dataModl.MenuName
                
                return cell
            
            }
        
        //}
        
        return UITableViewCell()
        
        
    }
        
    }

}
