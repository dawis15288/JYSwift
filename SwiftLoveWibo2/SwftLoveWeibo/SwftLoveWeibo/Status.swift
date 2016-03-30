//
//  Status.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SDWebImage

import SVProgressHUD

import Alamofire

class Status: NSObject {
    
    var created_at: String? {
    
        didSet {
        
            if let time = created_at {
                
                let formattr = NSDateFormatter()
                
                formattr.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
                
                formattr.locale = NSLocale(localeIdentifier: "en")
                
                let date = formattr.dateFromString(time)
                
                created_at = "\(date!.dateDesctiption)"
                
                if let date = NSDate.sinaDate(time) {
                
                    created_at = date.dateDesctiption
                    
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
    
    var stordLagrePictureURLs: [NSURL]?
    
    var pic_urls: [[String: AnyObject]]? {
        
        didSet {
            
            
            
            if pic_urls?.count == 0 {
                
                return
            
            }
            
            stordPictureURLs = [NSURL]()
            
            stordLagrePictureURLs = [NSURL]()
            
            for dicts in pic_urls! {
                
                if let urlString = dicts["thumbnail_pic"] as? String {
                    
                    stordPictureURLs?.append(NSURL(string: urlString)!)
                    
                    let largeURLs = urlString.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
                    
                    stordLagrePictureURLs?.append(NSURL(string: largeURLs)!)
                }
            
            }
        }
    
    }
    
    
    var user: User?
    
    /*reposts_count	int	转发数
    comments_count	int	评论数
    attitudes_count	int	表态数*/
    
    var repostsCount: Int?
    
    var commentsCount: Int?
    
    var attitudesCount: Int?
    
    var retweeted_Status: Status? {
        
        didSet {
            
            
        
        }
    
    }
    
    var repic_urls: [NSURL]? {
        
        
        
        return retweeted_Status != nil ? retweeted_Status?.stordPictureURLs : stordPictureURLs
    
    }
    
    var LargePictrueURLs: [NSURL]? {
    
        return retweeted_Status != nil ? retweeted_Status?.stordLagrePictureURLs : stordLagrePictureURLs
    }
    
    static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    private class func cacheWbImage(list: [Status], completedhandler: ((modules: [Status]?, error: NSError?) -> Void)? ) {
        
        if list.count == 0 {
        
            completedhandler!(modules: list, error: nil)
            
            return
            
        }
        
        let group = dispatch_group_create()
        
        for status in list {
            
            
            
            //guard let _ = status.stordPictureURLs else { continue }
            
           if let urlArray = status.repic_urls {
                
                for url in urlArray {
                    
                    dispatch_group_enter(group)
                    
                    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                        
                        dispatch_group_leave(group)
                        
                    })
                    
                }
            
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), { () -> Void in
                
                completedhandler!(modules: list, error: nil)
            
            })
        
        }
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("找不到\(key)")
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                
                user = User(dict: dict)
            }
            
            return
        }
        
        if "retweeted_status" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                retweeted_Status = Status(dict: dict)
                
                
            
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
    
    class func loadStatuses(since_id: Int, max_id: Int ,weiboAccessToken: String, completeionHandler: ((statuses: [Status]?, error: NSError?) -> Void)) {
        
        
        
        //dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
           // let urlStr = "https://api.weibo.com/2/statuses/friends_timeline.json?access_token=\(weiboAccessToken)&count=50&page=\(page)&base_app=0&feature=0&trim_user=0"
            
            var homeURL = "https://api.weibo.com/2/statuses/home_timeline.json?access_token=\(weiboAccessToken)"
            
            if since_id > 0 {
                
                homeURL = "\(homeURL)&since_id=\(since_id)"
            
            }
            
            if max_id > 0 {
                
                //为了避免获取到重复的微博数据 max_id - 1
                
                let maxID = max_id - 1
                
                homeURL = "\(homeURL)&max_id=\(maxID)"
            
            }
            
        Alamofire.request(.GET, homeURL).responseJSON(completionHandler: { (response) -> Void in
            
            if response.result.isSuccess {
                
                if let dataJSON = response.result.value {
                    
                    if let moduels = dataJSON["statuses"] as? [[String: AnyObject]] {
                        
                        
                        let statuses = self.status(moduels)
                        
                        cacheWbImage(statuses,completedhandler: completeionHandler)
                        
                        //completeionHandler(statuses: statuses, error: nil)
                        
                    }
                    
                }
            
            } else {
                
                completeionHandler(statuses: nil, error: response.result.error)
            
            }
            
            })
            
            /*let request = NSURLRequest(URL: NSURL(string: homeURL)!)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
                if response != nil {
                
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                        
                        do {
                        
                            let dataJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                            
                            if let moduels = dataJSON["statuses"] as? [[String: AnyObject]] {
                                
                                
                                let statuses = self.status(moduels)
                                
                                cacheWbImage(statuses,completedhandler: completeionHandler)
                                
                                //completeionHandler(statuses: statuses, error: nil)
                            
                            }
                            
                            
                        
                        } catch {}
                    
                    
                    }
                } else {
                    
                    completeionHandler(statuses: nil, error: error)
                    
                }
            
            })
            
            task.resume()*/
            
       // }
        
        
    }
    
    class func loadWeiboCommtents() {
        
        let url = "https://api.weibo.com/2/comments/show.json?access_token=2.009IxytBQHYE2Be1507ea6650oRSXl&id=3955785995922241"
        
        if let comententURL = NSURL(string: url) {
            
            let request = NSURLRequest(URL: comententURL)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                if let data = data {
                    
                    do {
                        
                        //let cmtentensJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                        
                        //let array = cmtentensJSON["comments"] as? [[String: AnyObject]]
                        
                        //print("获取大的评论是+++++++\(array!)+++++")
                        
                    } catch {}
                    
                }
                
            })
            
            task.resume()
            
        }
        
    }

}
