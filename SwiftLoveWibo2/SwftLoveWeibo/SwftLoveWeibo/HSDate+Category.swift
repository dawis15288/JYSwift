//
//  HSDate+Category.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/8.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func sinaDate(time: String) -> NSDate? {
    
        let formatter = NSDateFormatter()
        
        //EEE MM dd HH:mm:ss Z yyyy
        
        formatter.dateFromString("EEE MM dd HH:mm:ss Z yyyy")
        
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        return formatter.dateFromString(time)
        
    }
    
    var dateDesctiption: String {
    
        let cal = NSCalendar.currentCalendar()
        
        if cal.isDateInToday(self) {
            
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            
            if delta < 60 {
            
                return "刚刚"
                
            }
            
            if delta < 60 * 60 {
                
                return "\(delta/60)分钟前"
            
            }
            
            
            return "\(delta / ( 60 * 60)) 小时前"
            
        }
        
        var fmtString = " HH:mm"
        
        if cal.isDateInYesterday(self) {
            
            fmtString = "昨天" + fmtString
        
        } else {
        
            fmtString = "MM-dd" + fmtString
            
            let coms = cal.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            
            if coms.year > 0 {
            
                fmtString = "yyyy-" + fmtString
            }
        }
        
        let df = NSDateFormatter()
        
        df.locale = NSLocale(localeIdentifier: "en")
        
        df.dateFromString(fmtString)
        
        return df.stringFromDate(self)
    }

}