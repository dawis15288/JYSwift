//
//  Day.swift
//  JWatchWeatherProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

public enum Day: Int {
    
    case DayBeforeYesterday = -2
    
    case Yesterday
    
    case Today
    
    case Tomorrow
    
    case DayAfterTommorrow
    
    public var title: String {
        
        let result: String
        
        switch  self {
            
        case .DayBeforeYesterday:
            
            result = "前天"
            
        case .Yesterday:
            
            result = "昨天"
            
        case .Today:
            
            result = "今天"
            
        case .Tomorrow:
            
            result = "明天"
            
        case .DayAfterTommorrow:
            
            result = "后天"
        }
        
        return result
        
    }
    
}