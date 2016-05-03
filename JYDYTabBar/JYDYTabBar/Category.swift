//
//  Category.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    
    //返回值字段	字段类型	字段说明
    //var uid: String?	//推荐的用户id
    //var fans_coun: String?	//所推荐用户的被关注量
    //var is_follow: Int = 0//是否是我关注的用户
    //var gender: Int = 0	//性别,0为男，1为女
    //var screen_name: String?	//所推荐的用户昵称
    //var header:	String?	//所推荐的用户的头像url
    //var introduction: String?	//string	用户描述
    //var tiezi_count: Int = 0	//所发表的贴子数量
   // var total: Int = 0//一共加载了多少个推荐用户
    //var next_page: Int = 0//下一页的页码
    //var total_page: Int = 0//总共页码数
    
    

    var count: String?
    var id: String?
    var name: String?
    
    var nextPage: Int = 1
    
    
    var categoryUsers: [CategoryUser]?
    
    
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        self.count = dict["count"] as? String
        
        self.id = dict["id"] as? String
        
        self.name = dict["name"] as? String
        
        //setValuesForKeysWithDictionary(dict)
        
    }
    
    class func  model2Recommend(dicts: [[String: AnyObject]]) -> [Category] {
        
        var models = [Category]()
        
        for dict in dicts {
            
            models.append(Category(dict: dict))
            
        }
        
        return models
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
