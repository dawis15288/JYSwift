//
//  UIIMage+Category.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/15.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Foundation

extension UIImageView {
    
    func setWebImage(imageURL: String) {
        
        if let url = NSURL(string: imageURL) {
            
            let request = NSURLRequest(URL: url)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self] (data, response, error) -> Void in
                
                if (response as! NSHTTPURLResponse).statusCode == 200 {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.image = UIImage(data: data!)
                    
                    })
                
                
                }
            
            })
            
            task.resume()
        
        }
    
    }

}