//
//  WeiboModal.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/1/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

class WeiboModal {
    
    func getWeiboData(page: Int, weiboAccessToken: String, completionHandler: (data: JSON) -> Void) {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
            var urlStr = "https://api.weibo.com/2/statuses/friends_timeline.json?"
            
            urlStr += "access_token=\(weiboAccessToken)&"
            
            urlStr += "count=50&"
            
            urlStr += "page=\(page)&"
            
            urlStr += "base_app=0&"
            
            urlStr += "feature=0&"
            
            urlStr += "trim_user=0"
            
            print(urlStr)
            
            let request = NSURLRequest(URL: NSURL(string: urlStr)!)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                
                print(statusCode)
                
                if statusCode == 200 {
                    
                    do {
                        
                        //let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        
                        //let content =  as! AnyObjec
                        
                        let weiboJSON = JSON(data: data!)
                        
                        let weiboArray = weiboJSON["statuses"]
                        
                        completionHandler(data: weiboArray)
                        
                        
                    } catch {
                    
                    
                    
                    }
                    
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    
}
