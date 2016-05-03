//
//  ViewController.swift
//  JY-糗事百科数据
//
//  Created by atom on 16/4/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var page: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    @IBAction func getData(sender: AnyObject) {
        
        print("开始获取数据")
        
        let urlString = "http://m2.qiushibaike.com/article/list/suggest?count=20&page=3"
        
        let URL = NSURL(string: urlString)
        
        let req = NSURLRequest(URL: URL!)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(req) { (data, response, error) in
            
            if  let response = response as? NSHTTPURLResponse {
                
                let status = response.statusCode
                
                if status == 200{
                    
                    do {
                        
                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        
                        //dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            
                            if let itemes = jsonData["items"] as? [[String: AnyObject]] {
                                
                                let sta = Statues.model2status(itemes)
                                
                                for status in sta {
                                    
                                    if let user = status.user {
                                        
                                      print(user)
                                        
                                    }
                                    
                                    
                                
                                }
                                
                               //print(sta[3].user?.avatar_updated_at)
                                
                            }
                            
                            
                            
                        //}
                        
                    } catch _ {}
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

