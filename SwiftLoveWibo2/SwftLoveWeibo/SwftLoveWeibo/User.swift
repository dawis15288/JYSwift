//
//  User.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: Int = 0
    
    var name: String?
    
    var imageURL: NSURL?
    
    var profile_image_url: String? {
        
        didSet {
        
            imageURL = NSURL(string: profile_image_url!)!
        }
    
    }
    
    var verified: Bool = false
    
    var verified_type: Int = -1
    
    var verified_img: UIImage? {
    
        switch verified_type {
        
            case 0: return UIImage(named: "avatar_vip")
        
            case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        
            case 220: return UIImage(named: "avatar_grassroot")
            
            default: return nil
        
        }
    }
    
    var mbrank: Int = -1
    
    var membrImage: UIImage? {
        
        if mbrank > 0 && mbrank < 7 {
            
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        
        } else {
        
            return nil
        }
    
    }
    
    static let properties = ["id", "name", "profile_image_url", "verified", "verified_type"]
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("没有找到\(key)")
    }

}
