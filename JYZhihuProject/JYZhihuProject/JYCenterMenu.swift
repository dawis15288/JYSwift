//
//  JYCenterMenu.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

import SwiftyJSON

class MenuModel: NSObject {
    
    var MenuID: String = ""
    
    var MenuName: String = ""
    
    init(id: String, name: String) {
        
        self.MenuID = id
        
        self.MenuName = name
    
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.MenuID, forKey:  "MenuID")
        
        aCoder.encodeObject(self.MenuName, forKey:  "MenuName")
    
    }
    
    func initWithCoder(aDecoder: NSCoder) -> MenuModel {
        
        self.MenuName = aDecoder.decodeObjectForKey("MenuName") as! String
        
        self.MenuID = aDecoder.decodeObjectForKey("MenuID") as! String
        
        return self
    
    }

}
