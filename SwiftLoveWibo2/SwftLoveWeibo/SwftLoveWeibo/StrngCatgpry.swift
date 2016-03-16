//
//  StrngCatgpry.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


extension String {
    
    func cacheDir() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last! as NSString
        
        print( "\(path)<--->\((self as NSString).lastPathComponent)\n\n")
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    func docDir() -> String {
    
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
        
        ////path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    
    }
    
    
    func temp() -> String {
    
        let path = NSTemporaryDirectory() as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    
    }
    
}