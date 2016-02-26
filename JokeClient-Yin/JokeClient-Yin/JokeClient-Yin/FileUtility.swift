//
//  FileUtility.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
    
    class func cachePath(fileName: String) -> String {
        
        var arr = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        
        let path = arr[0]
        
        return "\(path)/\(fileName)"
    
    }
    
    class func imageCacheToPath(path: String, image:NSData) -> Bool {
        
        return image.writeToFile(path, atomically: true)
    
    }
    
    class func imageDataFromPath(path: String) -> AnyObject {
        
        let exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        
        if exist {
            
            let _ = NSData(contentsOfFile: path)
            
            let img = UIImage(contentsOfFile: path)
            
            let url = NSURL.fileURLWithPath(path)
            
            let dd = NSFileManager.defaultManager().contentsAtPath(url.path!)
            
            let _ = UIImage(data: dd!)
            
            if img != nil {
                
                return img!
            
            } else {
                
                return NSNull()
            
            }
        
        }
        
        return NSNull()
    
    }
    
}
