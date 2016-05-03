//
//  ViewController.swift
//  JYProject--百思不得姐
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

let JYCellReuseIdentifier = "JYCell"

class ViewController: UIViewController {
    
    var recommensData: [Recommends]? {
    
        didSet {
            
            print("\(recommensData?.count) ---- \(recommensData?.last?.theme_name)")
            
            jyTableView.reloadData()
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: ["a": "list", "c": "data", "type": "1"], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (
            response ) in
            if response.result.isSuccess {
            
            
                if let json = response.result.value {
                    
                    print("\(json)")
                
                
                }
            }
        }
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: ["a": "list", "c": "data", "type": "1"], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseData { (response) in
            
            if response.result.isSuccess {
                
                
                do {
                    
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    let data = jsonData["list"] as! [[String: AnyObject]]
                    
                    print(data)
                    
                } catch {}
                
                
            }
        }

        
        BudejieNetTool.RecommendData { (recommens, errr) in
            
            if recommens != nil && errr == nil {
                
                let mdels = Recommends.model2Recommend(recommens!)
                
                self.recommensData = mdels
            
            }
            
        }
        
    }
    
    private func setupTableView() {
    
        view.addSubview(jyTableView)
        
        jyTableView.xmg_Fill(view)
    
    }
    
    private lazy var jyTableView: UITableView = {
        
        let tableView = UITableView()
          
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: JYCellReuseIdentifier)
        
        return tableView
    
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommensData?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(JYCellReuseIdentifier, forIndexPath: indexPath)
        
        let recmment = self.recommensData![indexPath.row]
        
        cell.textLabel?.text = recmment.theme_name
        
        return cell
    }
}

