//
//  Comments.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Comments: NSObject {
    
    var liked: Bool?
    
    var floor: Int = 0
    
    var created_at: Int = 0
    
    var content: String?
    
    var like_count: Int = 0
    
    var user: CommentUser?
    
    var id: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                user = CommentUser(dict: dict)
            
            }
            
            
            return
        
        }
        
        super.setValue(value, forKey: key)
        
    }
    
    class func model2comment(models: [[ String: AnyObject]]) -> [Comments] {
        
        var dicts = [Comments]()
        
        for dict in models {
            
            dicts.append(Comments(dict: dict))
        
        }
    
        return dicts
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
