//
//  User.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/19.
//  Copyright © 2016年 cyin. All rights reserved.
//


import UIKit

class User: NSObject {
    
    var avatar_updated_at: Int = 0
    
    var uid: Int = 0
    
    var last_visited_at: Int = 0
    
    var created_at: Int = 0
    
    var state: String?
    
    var last_device: String?
    
    var role: String?
    
    var login: String?
    
    var id: Int = 0
    
    var icon: String?
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("没有找到\(key)")
    }

}
