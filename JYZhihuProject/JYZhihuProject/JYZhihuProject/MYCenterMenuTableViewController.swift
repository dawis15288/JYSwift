//
//  TableViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit


import Alamofire

import SwiftyJSON

class TableViewController: UITableViewController {
    
    var menuArray: [MenuModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuData = NSUserDefaults.standardUserDefaults().objectForKey("MyCenterMenuArrayKey")
        
        if menuData == nil {
        
            let array: [MenuModel] = []
            
            NSUserDefaults.standardUserDefaults().setObject(array, forKey: "MyCenterMenuArrayKey")
        } else {
            
            let data: NSData = menuData as! NSData
            
            self.menuArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [MenuModel]
        
        }
        
        getMenuData()
    }
    
    func getMenuData() {
        
        Alamofire.request(.GET, "http://nws-at.zhihu.com/api/4/themes").responseJSON(completionHandler: { [ unowned self ](response) -> Void in
            
            guard response.result.error == nil else {
            
                print("加载失败")
                
                return
            }
            
            self.menuArray = []
            
            if let data =  response.data {
                
                let data = JSON(data: data)["others"]
                
                for i in 0 ..< data.count {
                
                    let dataModel = MenuModel(id: String(data[i]["id"]), name: data[i]["name"].string!)
                    
                    self.menuArray.append(dataModel)
                
                }
            
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
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
