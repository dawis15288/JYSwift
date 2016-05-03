//
//  Statues.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Statues: NSObject {
    
    var format: String?
        
    var image: String?
    
    //var imageID: String?
    
    var tag: String?
    
    var id: Int = 0
        
   var published_at: Int = 0
        
    var user: User?
    
    var votes: Votes?
    
    var created_at: Int = 0
    
    var content: String?
    
    var state: String?
    
    var comments_count: Int = 0
    
    var allow_comment: Bool?
    
    var share_count: Int = 0
    
    var type: String?
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                
                user = User(dict: dict)
                
            }
            
            return
        }
        
        if "votes" == key {
            
            if let dict = value as? [String: AnyObject] {
                
                votes = Votes(dict: dict)
            }
            
            return
            
        }
        
        super.setValue(value, forKey: key)
    }
    
    class func model2status(array: [[String: AnyObject]]) -> [Statues] {
        
        var models = [Statues]()
        
        for dicts in array {
            
            models.append(Statues(dict: dicts))
            
        }
        
        return models
        
    }
    
    

}
