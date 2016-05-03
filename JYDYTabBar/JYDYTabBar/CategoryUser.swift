//
//  CategoryUser.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/25.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class CategoryUser: NSObject {
    
    var fans_count: String?
    var gender: Int = 0
    var header: String?
    var introduction: String?
    var is_follow: Int = 0
    var is_vip: Int = 0
    var screen_name: String?
    var tiezi_count: Int = 0
    var uid: String?
    var next_page: Int = 0
    var total: Int = 0
    var total_page: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        //setValuesForKeysWithDictionary(dict)
        
        self.fans_count = dict["fans_count"] as? String
        
        self.gender = (dict["gender"] as? Int)!
        
        self.header = dict["header"] as? String
        
        self.introduction = dict["introduction"] as? String
        
        self.is_follow = (dict["is_follow"] as? Int)!
        
        self.is_vip = (dict["is_vip"] as? Int)!
        
        self.screen_name = dict["screen_name"] as? String
        
        self.tiezi_count = (dict["tiezi_count"] as? Int)!
        
        self.uid = dict["screen_name"] as? String
     
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    
    
    class func  model2Recommend(dicts: [[String: AnyObject]], total: Int, next_page: Int, total_page: Int) -> [CategoryUser] {
        
        var models = [CategoryUser]()
        
        for dict in dicts {
            
            let user = CategoryUser(dict: dict)
            
            user.total = total
            
            user.next_page = next_page
            
            user.total_page = total_page
            
            models.append(user)
            
        }
        
        return models
    }
    

}
