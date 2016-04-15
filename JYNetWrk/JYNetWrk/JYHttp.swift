//
//  JYHttp.swift
//  JYNetWrk
//
//  Created by atom on 16/4/11.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

enum RequestMethod{
    case Post
    case Get
}

typealias jyht = JYHTTP

class JYHTTP: NSObject {
    
    private var method: RequestMethod
    
    private let hostName = ""
    
    private var curUrl = ""
    
    private var parameters : [String : AnyObject] = [:]
    
    static let shareInstanc = JYHTTP(m: .Get)
    
    init(m: RequestMethod) {
        
        method = m
        
        super.init()
        
        self.setDefaultParas()
    
    }
    
    private func setDefaultParas() {
        
        self.parameters = [:]
        
        _ = defaultParas().reduce("", combine: { (str, p) -> String in
            
            self.parameters[p.0] = p.1
            
            return ""
        })
    
    }
    
    private func defaultParas() -> [String : AnyObject] {
        
        var result: [String : AnyObject] = [:]
        
        let version = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]
        
        result["version"] = version
        
        result["app_type"] = "jyhttp_demo"
        
        return result
    
    }
    
    func fetch(url: String) -> JYHTTP {
        
        setDefaultParas()
        
        curUrl = "\(hostName)\(url)"
        
        self.method = .Post
        
        return self
    
    }

}
