//
//  Comments.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Comments: NSObject {
    
    
    var created_at: String?
    var id: Int = 0
    var text: String?
    var source: String?
    var mid: String?
    
    var status: CmmentStatus?
    
    var previous_cursor: Int = 0
    
    var next_cursor: Int = 0
    
    var total_number: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        
        
        if "status" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                status = CmmentStatus(dict: dict)
                
                
                
            }
            
            return
            
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func model2Comments(array: [[String: AnyObject]]) -> [Comments] {
        
        var models = [Comments]()
        
        for dicts in array {
            
            models.append(Comments(dict: dicts))
            
        }
        
        return models
    }

}
