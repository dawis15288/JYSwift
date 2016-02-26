//
//  JYHttprRequest.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Foundation

class JYHttprRequest: NSObject {
    
    override init() {
        
        super.init()
        
    }
    
    class func requestWithURL(urlString: String, completionHandler:(data: AnyObject) -> Void) {
        
        let URL = NSURL(string: urlString)
        
        let req = NSURLRequest(URL: URL!)
        
        /**/
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(req) { (data ,response, error) -> Void in
            
            if  let response = response as? NSHTTPURLResponse {
                
                let status = response.statusCode
                
                if status != 200 && error != nil {
                    
                    dispatch_async(dispatch_get_main_queue()){ () -> Void in
                        
                        print(error?.localizedDescription)
                        
                        completionHandler(data: NSNull())
                        
                    }
                    
                    
                } else {
                    
                    do {
                        
                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            
                            completionHandler(data: jsonData)
                            
                        }
                        
                    } catch _ {}
                    
                }
            
            }
            
            
            
        
        }
        
        task.resume()
    
    }

}
