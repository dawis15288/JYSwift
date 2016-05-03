//
//  BudejieNetTool.swift
//  JYProject--百思不得姐
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

class BudejieNetTool: NSObject {
    
    class func RecommendData(completeHandler: (recommens: [Recommends]?,errr: NSError?) -> Void ) {
        
        var params = [String: String]()
        
        params["a"] = "tag_recommend"
        
        params["action"] = "sub"
        
        params["c"] = "topic"
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: params, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                do {
                    
                    let jsondata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    let recommens = jsondata as! [[String: AnyObject]]
                    
                    let recommenss = Recommends.model2Recommend(recommens)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        completeHandler(recommens: recommenss,errr: nil)
                        
                    })
                    
                    
                    
                } catch {}
                
            }
            
            
        }
    
    }
    
    class func CategoryData(completeHandler: (category: [Category]?,errr: NSError?) -> Void ) {
        
        var params = [String: String]()
        
        params["a"] = "category"
        
        params["c"] = "subscribe"
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: params, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (
            response) in
            
            if response.result.isSuccess {
                
                do {
                    
                    let jsondata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    let category = jsondata["list"] as! [[String: AnyObject]]
                    
                    let mdels = Category.model2Recommend(category)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        completeHandler(category: mdels, errr: nil)
                        
                    })
                    
                    
                    
                    
                } catch {}
            
            }
            
        }
        
    }
    
    class func loadThememage(url: String? ,completeHandler: (data: NSData?,errr: NSError?) -> Void ) {
    
        Alamofire.request(.GET, url!).responseData { (response) in
            
            if response.result.isSuccess {
            
                dispatch_async(dispatch_get_main_queue(), {
                    
                    completeHandler(data: response.data, errr: nil)
                    
                })
            }
        }
    
    }
    
    class func 	listData(id: String?, nextPage: Int?, completeHandler: (categoryUser: [CategoryUser]?,errr: NSError?) -> Void ){ //,
        
        var params = [String: AnyObject]()
        
        params["a"] = "list"
        
        params["c"] = "subscribe"
        
        params["category_id"] = id!
        
        if nextPage > 1 {
            
            params["page"] = "\(nextPage!)"
            
        
        }
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: ["a": "list", "c": "subscribe", "category_id": id!, "page": "\(nextPage!)"], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseData { (
            response) in
            
            if response.result.isSuccess {
                
                do {
                    
                    let jsondata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    
                    
                    let categorys = jsondata["list"] as! [[String: AnyObject]]
                    
                    let total = jsondata["total"] as! Int
                    
                    let next_page = jsondata["next_page"] as! Int
                    
                    let total_page = jsondata["total_page"] as! Int
                    
                    let categoryUsers = CategoryUser.model2Recommend(categorys, total: total, next_page: next_page, total_page: total_page)
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        completeHandler(categoryUser: categoryUsers, errr: nil)
                        
                    })
                    
                    
                    
                } catch {}
                
            }
            
        }
    
    }
    
    class func loadHomeData(parameters: [String: String]?, completeHandler: (jyTopic: [JYTopics]?, jyTopicInfo: JYTopicInfo? , error: NSError?) -> Void ) {
        
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: parameters!, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseData { (response) in
            
            if response.result.isSuccess {
                
                
                do {
                
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    let jyTopicInfo = JYTopicInfo(dict: jsonData["info"] as! [String: AnyObject])
                    
                    let jyTopics = JYTopics.model2Topic(jsonData["list"] as! [[String: AnyObject]])
                    
                    completeHandler(jyTopic: jyTopics, jyTopicInfo: jyTopicInfo , error: nil)
                
                } catch {}
            
            
            }
        }
        
    
    }
}
