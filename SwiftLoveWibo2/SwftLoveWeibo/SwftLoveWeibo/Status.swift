//
//  Status.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SDWebImage

class Status: NSObject {
    
    var created_at: String? {
    
        didSet {
        
            if let time = created_at {
                
                let formattr = NSDateFormatter()
                
                formattr.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
                
                formattr.locale = NSLocale(localeIdentifier: "en")
                
                let date = formattr.dateFromString(time)
                
                print(date?.dateDesctiption)
                
                created_at = "\(date!.dateDesctiption)"
                
                if let date = NSDate.sinaDate(time) {
                
                    created_at = date.dateDesctiption
                    print("created_at\(date.dateDesctiption)\n\n------>")
                    
                }

            
            }
        }
    }
    
    var id: Int = 0
    
    var text: String?
    
    var source: String? {
        
        didSet {
            
            if let str = source {
                
                //let start = ( str as NSString).rangeOfString(">").location + 1
                
                //let end = (str as NSString).rangeOfString("</").location
                
                //let length = end - start
                
                //let res = (str as NSString).substringWithRange(NSRange(location: start, length: length))
                
                //source = "来自: \(res)"
                
                print(str)
                
                if let start = str.rangeOfString(">")?.startIndex {
                    
                    let res = str.substringFromIndex(start)
                    
                    if let end = res.rangeOfString("</")?.endIndex {
                        
                        let client = res.substringToIndex(end)
                        
                        let sub = client.stringByReplacingOccurrencesOfString(">", withString: "")
                        
                        let res = sub.stringByReplacingOccurrencesOfString("</", withString: "")
                        
                        source = "来自: \(res)"
                    
                    }
                
                }
                
                
            
            }
        
        }
    
    }
    
    var stordPictureURLs: [NSURL]?
    
    var pic_urls: [[String: AnyObject]]? {
        
        didSet {
            
            print("var pic_urls: [[String: AnyObject]]?------->\(pic_urls)")
            
            if pic_urls?.count == 0 {
                
                return
            
            }
            
            stordPictureURLs = [NSURL]()
            
            for dicts in pic_urls! {
                
                if let urlString = dicts["thumbnail_pic"] as? String {
                    
                    stordPictureURLs?.append(NSURL(string: urlString)!)
                    
                
                }
            
            }
        }
    
    }
    
    
    var user: User?
    
    static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    private class func cacheWbImage(list: [Status] ) {
    
        
        let group = dispatch_group_create()
        
        for status in list {
            
            guard let _ = status.stordPictureURLs else { continue }
            
            for url in status.stordPictureURLs! {
                
                dispatch_group_enter(group)
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.RefreshCached, progress: nil, completed: { (_, _, _, _, _) -> Void in
                    
                    print(SDWebImageOptions.RefreshCached.rawValue)
                
                    dispatch_group_leave(group)
                    
                })
            
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), { () -> Void in
                
                //completedhandler(statues: list, error: nil)
                
                print("cacheWbImage已经成功")
            
            })
        
        }
    
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
                            
                            cacheWbImage(models)
                            
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
