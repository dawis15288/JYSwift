//
//  networkTool.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Alamofire

import SDWebImage

class weiboNetWorkTool {
    
    class func sendWeibo(image: UIImage?, status: String?, completeHandler: ((error: NSError?) -> Void)?) {
        
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
            
            if image != nil {
                
                let pic = UIImagePNGRepresentation(image!)
                
                Alamofire.upload(.POST, "https://upload.api.weibo.com/2/statuses/upload.json", multipartFormData: { (formData) in
                    
                    formData.appendBodyPart(data: pic!, name: "pic", fileName: "swft.png", mimeType: "application/octet-stream")
                    
                    formData.appendBodyPart(data: weiboAccessToken.dataUsingEncoding(NSUTF8StringEncoding)!, name: "access_token")
                    
                    let status = status!
                    
                    formData.appendBodyPart(data: status.dataUsingEncoding(NSUTF8StringEncoding)!, name: "status")
                    
                    }, encodingCompletion: { ( encodingResult) in
                        
                        switch encodingResult {
                            
                        case .Success(let upload, _, _):
                            
                            upload.responseJSON { response in
                                debugPrint(response.result.value)
                                
                                completeHandler!(error: nil)
                                
                            }
                        case .Failure(let encodingError):
                            print(encodingError)
                            
                            completeHandler!(error: NSError(domain: "failure", code: 404, userInfo: nil))
                        }
                        
                })
                
                
            } else {
                
                
                
                Alamofire.request(.POST, "https://api.weibo.com/2/statuses/update.json", parameters: ["access_token": weiboAccessToken, "status": status!]).responseJSON(completionHandler: { (response) -> Void in
                    
                    if response.response?.statusCode == 200 {
                        
                        completeHandler!(error: nil)
                    }
                    
                })
                
            }
            
            
            
        }
    
    }
    
    class func getAccesstoken(postParms: String?, completeHandler: (() -> Void)?) {
    
        Alamofire.request(.POST, postParms!).responseJSON(completionHandler: { (response) -> Void in
            
            if response.result.isSuccess {
                
                if let dataDictionary = response.result.value {
                    
                    let account = UserAccount(dict: dataDictionary as! [String: AnyObject])
                    
                    account.loadUserInfo({ (account, error) -> Void in
                        
                        print("在获取令牌的同时获取用户信息\(account?.expires_Date)")
                        
                        if account != nil && error == nil{
                            
                            account!.saveAccount()
                            
                            completeHandler!()
                        }
                        
                    })
                }
                
                
            }
            
        })
    }
    
    class func getWeiData(homeURL: String?, completeionHandler: ((moduels: [[String: AnyObject]]?,error: NSError?) -> Void)?) {
    
        Alamofire.request(.GET, homeURL!).responseJSON(completionHandler: { (response) -> Void in
    
        if response.result.isSuccess {
    
        if let dataJSON = response.result.value {
    
        if let moduels = dataJSON["statuses"] as? [[String: AnyObject]] {
    
    
            //let statuses = self.status(moduels)
    
                //cacheWbImage(statuses!,completedhandler: completeionHandler!)
            completeionHandler!(moduels: moduels, error: nil)
    
            //completeionHandler(statuses: statuses, error: nil)
    
                }
    
            }
    
        } else {
    
            //completeionHandler(statuses: nil, error: response.result.error)
            
                //completedhandler!(error: response.result.error)
            
                completeionHandler!(moduels: nil, error: response.result.error)
    
            }
    
        })
    }
    
    class func getUserinfo(urlString: String?, compeletedhandler: ((dataDict: AnyObject?, error: NSError?) -> Void)?) {
        
        Alamofire.request(.GET, urlString!).responseJSON(completionHandler: { (response) -> Void in
            
            if response.result.isSuccess {
                
                if  let dataDict = response.result.value {
                    
                    compeletedhandler!(dataDict: dataDict, error: nil)
                    
                }
                
                
            }
        })
    
    }
    
    
    class func loadStatuses(since_id: Int, max_id: Int ,weiboAccessToken: String, completeionHandler: ((statuses: [Status]?, error: NSError?) -> Void)) {
        
        var homeURL = "https://api.weibo.com/2/statuses/home_timeline.json?access_token=\(weiboAccessToken)"
        
        if since_id > 0 {
            
            homeURL = "\(homeURL)&since_id=\(since_id)"
            
        }
        
        if max_id > 0 {
            
            //为了避免获取到重复的微博数据 max_id - 1
            
            let maxID = max_id - 1
            
            homeURL = "\(homeURL)&max_id=\(maxID)"
            
        }
        
        
        
        weiboNetWorkTool.getWeiData(homeURL) {(moduels, error) in
            
            if error == nil && moduels != nil {
                
                if let moduels = moduels {
                    
                    let stsues = Status.status(moduels)
                    
                    
                    
                    //Status.cacheWbImage(stsues, completedhandler: completeionHandler)
                    
                    self.cacheWbImage(stsues, completedhandler: completeionHandler)
                    
                }
                
            } else {
                
                completeionHandler(statuses: nil, error: error)
            }
        }
        
        
    }
    
    // completedhandler: ((modules: [Status]?, error: NSError?) -> Void)?
    
    class func cacheWbImage(list: [Status], completedhandler: ((modules: [Status]?, error: NSError?) -> Void)?) {
        
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
    
    //https://api.weibo.com/2/comments/show.json
    
    class func loadComments(weiboAccessToken: String, webId: Int, completedhandler: ((modules: [Comments]?, error: NSError?) -> Void)?) {
        
        let commentsURL = "https://api.weibo.com/2/comments/show.json?access_token=\(weiboAccessToken)&id=\(webId)"
        
        
    
        Alamofire.request(.GET, commentsURL).responseJSON(completionHandler: { (response) -> Void in
            
            if response.result.isSuccess {
                
                
                if let data = response.data {
                    
                    do {
                        
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        
                        let comments = json["comments"] as! [[String: AnyObject]]
                        
                        let cmment = Comments.model2Comments(comments)
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            completedhandler!(modules: cmment, error:  nil )
                            
                        })
                        
                        
                        
                    
                    } catch {}
                
                }
            
            }
        })
        
    }
    
}
