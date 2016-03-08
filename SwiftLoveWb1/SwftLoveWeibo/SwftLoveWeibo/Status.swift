//
//  Status.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var created_at: String?
    
    var id: Int = 0
    
    var text: String?
    
    var source: String?
    
    var pic_urls: [[String: AnyObject]]?
    
    var user: User?
    
    static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("找不到\(key)")
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User(dict: dict)
            }
            
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    private class func status(array: [[String: AnyObject]]) -> [Status] {
    
        var models = [Status]()
        
        for dicts in array {
            
            models.append(Status(dict: dicts))
        
        }
        
        return models
    }
    
    class func loadStatuses(page: Int, weiboAccessToken: String, completeionHandler: ((statuses: [Status]?, error: NSError?) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
            var urlStr = "https://api.weibo.com/2/statuses/friends_timeline.json?"
            
            urlStr += "access_token=\(weiboAccessToken)&"
            
            urlStr += "count=50&"
            
            urlStr += "page=\(page)&"
            
            urlStr += "base_app=0&"
            
            urlStr += "feature=0&"
            
            urlStr += "trim_user=0"
            
            let request = NSURLRequest(URL: NSURL(string: urlStr)!)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    
                    do {
                        
                        
                        let dataJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        
                        //statuses
                        
                        if let weiboJSON = dataJSON["statuses"] as? [[String: AnyObject]] {
                            
                            let models = Status.status(weiboJSON)
                            
                            completeionHandler(statuses: models, error: nil)
                        
                        }
                        
                        
                        
                        
                    } catch _ {
                        
                        
                        
                    }
                    
                    
                }
                
            }
            
            task.resume()
            
        }
        
        
    }

}
