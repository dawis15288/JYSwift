//
//  JYNet.swift
//  JYNetWrk
//
//  Created by atom on 16/4/11.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYNet: NSObject {
    
    class func request(method: String = "GET", url: String, dataForm: Dictionary<String, AnyObject> = [:], success: (data: NSData?) -> Void, fail: (error: NSError?) -> Void) {
        
        var innerURL = url
        
        if method == "GET" {
            
            innerURL += "?" + JYNet().buildParams(dataForm)
            
        }
        
        
        
        if let url = NSURL(string: innerURL) {
            
            let requesst = NSMutableURLRequest(URL: url)
            
            requesst.HTTPMethod = method
            
            if method == "POST" {
                
                requesst.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                requesst.HTTPBody = JYNet().buildParams(dataForm).dataUsingEncoding(NSUTF8StringEncoding)
            
            }
            
            let session = NSURLSession.sharedSession()
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(requesst, completionHandler: { (data, response, error) in
                
                if error != nil {
                    
                    fail(error: error)
                
                } else {
                
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                        
                        success(data: data)
                    
                    } else {
                        
                        fail(error: error)
                    
                    }
                }
            })
            
            task.resume()
            
        }
        
        
        
    }
    
    func escape(string: String) -> String {
        
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        
        
       // string.stringByAddingPercentEncodingWithAllowedCharacters(<#T##allowedCharacters: NSCharacterSet##NSCharacterSet#>)
        
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
        
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        
        var components: [(String, String)] = []
        
        if let dic = value as? [String: AnyObject] {
            
            for (nestedkey, value) in dic {
                
                components += queryComponents("\(key)[\(nestedkey)]", value)
            
            }
        
        } else if let array = value as? [AnyObject] {
            
            for value in array {
                
                components += queryComponents("\(key)", value)
            }
        
        } else {
            
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        
        }
        
        return components
        
    }
    
    func buildParams(parameters: [String: AnyObject]) -> String {
        
        var components: [(String, String)] = []
        
        for key in Array(parameters.keys).sort() {
            
            let value: AnyObject! = parameters[key]
            
            components += self.queryComponents(key, value)
        
        }
        
        return (components.map({ "\($0)=\($1)"}) as [String]).joinWithSeparator("&")
        
        
    }
    
    

}
