//
//  CmmentUser.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/23.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class CmmentUser: NSObject {
    
    var id: Int = 0
    var screen_name: String?
    
    var name: String?
    
    var province: String?
    
    var city: String?
    
    var location: String?
    var userDescription: String?
    var url: String?
    var profile_image_url: String?
    var domain:String?
    var gender: String?
    var followers_count: Int = 0
    var friends_count: Int = 0
    var statuses_count: Int = 0
    var favourites_count: Int = 0
    var created_at: String?
    var following: Bool?
    var allow_all_act_msg: Bool?
    var remark: String?
    var geo_enabled: Bool?
    
    var verified: Bool?
    var allow_all_comment: Bool?
    var avatar_large: String?
    var verified_reason: String?
    var follow_me: Bool?
    var online_status: Int = 0
    var bi_followers_count: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        
        
        super.init()
        
        
        self.setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }

}
