//
//  Recommend.swift
//  JYProject--百思不得姐
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Recommends: NSObject {
    
    //返回值字段	字段类型	字段说明
    var is_sub: Int = 0	//int	是否含有子标签
    var theme_id: String?	//string	此标签的id
    var theme_name:	String? //:	标签名称
    var sub_number: String?	//string	此标签的订阅量
    var is_default: Int = 0	//int	是否是默认的推荐标签
    var image_list: String?	{
        
        didSet {
            
            
        
        }
    
    }//string	推荐标签的图片url地址
    
    init(dict: [String: AnyObject]) {
    
        super.init()
        
        //setValuesForKeysWithDictionary(dict)
        
        self.image_list = dict["image_list"] as? String
        
        self.is_default = (dict["is_default"] as? Int)!
        
        self.is_sub = (dict["is_sub"] as? Int)!
        
        self.theme_id = dict["theme_id"] as? String
        
        self.theme_name = dict["theme_name"] as? String
        
        self.sub_number = dict["sub_number"] as? String
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    class func  model2Recommend(dicts: [[String: AnyObject]]) -> [Recommends] {
    
        var models = [Recommends]()
        
        for dict in dicts {
        
            models.append(Recommends(dict: dict))
        
        }
        
        return models
    }


}
