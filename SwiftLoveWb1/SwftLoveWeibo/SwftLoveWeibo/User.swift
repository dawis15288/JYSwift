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
    
    static let properties = ["id", "name", "profile_image_url", "verified", "verified_type"]
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("没有找到\(key)")
    }

}
