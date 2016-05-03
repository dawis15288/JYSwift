//
//  JYTopicInfo.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYTopicInfo: NSObject {

    var maxtime: String?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        self.maxtime = dict["maxtime"] as? String
        
    }

}
