//
//  Chart.swift
//  JYHTMLProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

class Chart {
    
    let title: String
    
    let url: NSURL
    
    let number: Int
    
    let scale: Int
    
    required init(title: String, url: NSURL, number: Int, scale: Int) {
        
        self.title = title
        
        self.url = url
        
        self.number = number
        
        self.scale = scale
    
    }
    
    
    var filename: String? {
        
        print("url.lastPathComponent ---> \(url.lastPathComponent)")
        
        return url.lastPathComponent
    
    }
    
    var urlInDocumentsDirectory: NSURL? {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        if paths.count > 0 {
            
            let path = paths[0]
            
            if let dicretory = NSURL(string: path), filename = filename {
                
                let fileURL = dicretory.URLByAppendingPathComponent(filename)
                
                print("urlInDocumentsDirectory-->\(fileURL.path)")
                
                return fileURL
            
            }
        
        }
        
        return nil
    
    }
    
    
}
