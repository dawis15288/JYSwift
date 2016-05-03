//
//  UIImageViewWebExt.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import UIKit

extension UIImageView {

    func setImage(urlString: String, placeHolder: UIImage!) {
        
        let url = NSURL(string: urlString)
        
        let cacheFileName = url!.lastPathComponent
        
        let cachePath = FileUtility.cachePath(cacheFileName!)
        
        let image: AnyObject = FileUtility.imageDataFromPath(cachePath)
        
        if image as! NSObject != NSNull() {
            
            self.image = image as? UIImage
        
        } else {
        
            let req = NSURLRequest(URL: url!)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(req) { (data, response, error) -> Void in
                
                if let response = response as? NSHTTPURLResponse {
                    
                    let status = response.statusCode
                    
                    if status == 200 {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            if let data = data {
                                
                                let image = UIImage(data: data)
                                
                                self.image = image
                                
                                if image == nil {
                                    
                                    do {
                                        
                                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                                        
                                        if let _:String? = jsonData["error"] as? String {
                                            
                                            print("url fail = \(urlString)")
                                            
                                        }
                                        
                                        self.image = placeHolder
                                        
                                    } catch _ {
                                        
                                    }
                                    
                                } else {
                                    
                                    
                                }
                                
                            
                            }
                            
                            
                            
                            
                        
                    })
                    
                }
                
            }
                
            }
            
            task.resume()
            
            
        }
        
        }
        
        
}
