//
//  ViewController.swift
//  JYSompleRESTPrpject
//
//  Created by atom on 16/2/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Foundation

class ViewController: UIViewController {
    
    let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let url = NSURL(string: postEndpoint) else {
            
            print("Error: cannot create URL")
            
            return
            
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) -> Void in
            
            if (response as! NSHTTPURLResponse).statusCode == 200 {
                
                let jsonDatas: NSArray!
                
                do {
                    
                    guard let jsonData = data else { return }
                    
                    jsonDatas = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSArray
                    
                    print(jsonDatas.description)
                
                } catch _ {
                
                
                }
            
            }
        
        })
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

