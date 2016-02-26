//
//  NSDictionaryExt.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import UIKit

extension NSDictionary {
    
    func stringAttributeForkey(key: String) -> String {
        
        
        
        let obj: AnyObject? = self[key]
        
        if let _ = obj as? NSObject {
            
        
        } else {
        
            return ""
        
        }
        
        if obj!.isKindOfClass(NSNumber) {
            
            let num = obj as! NSNumber
            
            return num.stringValue
        
        }
        
        if let _ = obj as? String {
        
            return obj as! String
        
        }
        
        return ""
    
    }


}
