//
//  CmmentStatus.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/23.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class CmmentStatus: NSObject {
    
    var created_at: String?
    var id: Int = 0
    var text: String?
    var source: String?
    var favorited: Bool?
    var truncated: Bool?
    var in_reply_to_status_id: String?
    
    var in_reply_to_user_id: String?
    var in_reply_to_screen_name: String?
    var geo: Bool?
    var mid: String?
    var reposts_count: Int = 0
    var comments_count: Int = 0
    var annotations: [AnyObject]?
    
    var user: CmmentUser?
    
    init(dict: [String: AnyObject]) {
        
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
        
    
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                user = CmmentUser(dict: dict)
                
            }
            
            return
            
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
       
    }

}
