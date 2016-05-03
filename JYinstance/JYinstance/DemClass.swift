//
//  DemClass.swift
//  JYinstance
//
//  Created by atom on 16/4/17.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

class DemoClass {
    
    
    class var sharedInstance: DemoClass {
        
        struct Static {
            
            static var onceToken: dispatch_once_t = 0
            
            static var instance:DemoClass? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            
            Static.instance = DemoClass()
        }
        
        return Static.instance!
    }
    
    
}

let dembject = DemoClass.sharedInstance

class DemoClass2 {
    
    class var sharedInstance: DemoClass2 {
        
        struct Static {
            
            static let instance = DemoClass2()
        }
        
        return Static.instance
        
    }
}

class DemoClass3 {
    
    
    
    class var sharedInstance: DemoClass3 {
        
        return sharedInstance3
        
    }
    
    
    
}

private let sharedInstance3: DemoClass3 = DemoClass3()

class DemoClass4 {
    
    static let sharedInstance = DemoClass4()

}


