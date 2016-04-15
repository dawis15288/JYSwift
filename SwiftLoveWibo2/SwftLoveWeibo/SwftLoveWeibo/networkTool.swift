//
//  networkTool.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Alamofire


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
    
    
    
    
}
