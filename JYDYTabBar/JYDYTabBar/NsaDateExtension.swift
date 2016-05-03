//
//  NsaDateExtension.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension NSDate {
    
    
    func equalDate(fromDate: String?) ->  (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
    
        let  calendar = NSCalendar.currentCalendar()
    
        let create = NSDateFormatter()
    
        create.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        let fromDate = create.dateFromString(fromDate!)
        
    
        let year = calendar.components(NSCalendarUnit.Year, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).year
    
        let month = calendar.components(NSCalendarUnit.Month, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).month
        
        let day = calendar.components(NSCalendarUnit.Day, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).day
    
        let hour = calendar.components(NSCalendarUnit.Hour, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).hour
    
        let minute = calendar.components(NSCalendarUnit.Minute, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).minute
    
        let second = calendar.components(NSCalendarUnit.Second, fromDate: fromDate!, toDate: self, options: NSCalendarOptions(rawValue: 0)).second
        
        
        return (year, month, day, hour, minute, second)
    
    }



}
