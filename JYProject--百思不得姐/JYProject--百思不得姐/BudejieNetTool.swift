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
    
    class func RecommendData(completeHandler: (recommens: [[String: AnyObject]]?,errr: NSError?) -> Void ) {
        
        var params = [String: String]()
        
        params["a"] = "tag_recommend"
        
        params["action"] = "sub"
        
        params["c"] = "topic"
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: params, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseData { (response) in
            
            if response.result.isSuccess {
                
                do {
                    
                    let jsondata = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    let recommens = jsondata as! [[String: AnyObject]]
                    
                    completeHandler(recommens: recommens,errr: nil)
                    
                } catch {}
                
            }
            
            
        }
    
    }
    

}
