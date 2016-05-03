//
//  Votes.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class Votes: NSObject {
    
    var down: Int = 0
    
    
    var up: Int = 0
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        print("没有找到\(key)")
    }

}
