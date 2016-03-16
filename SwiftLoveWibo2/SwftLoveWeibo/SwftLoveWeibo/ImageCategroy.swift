//
//  ImageCategroy.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setJYImageWithURL(imageWithURL: String) {
    
        if let imageURL = NSURL(string: imageWithURL) {
    
            let request = NSURLRequest(URL: imageURL)
    
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
            let task = session.dataTaskWithRequest(request, completionHandler: { [unowned self] (data, response, error) -> Void in
    
                if response != nil {
    
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
    
    
    
                        if let data = data {
    
                            dispatch_async(dispatch_get_main_queue(), {  () -> Void in
    
                                self.image = UIImage(data: data)
                            })
    
                        }
    
                    }
    
                }
    
                })
    
            task.resume()
    
        }
    
    }

}
