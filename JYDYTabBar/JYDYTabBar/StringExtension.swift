//
//  StringExtension.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

extension String {

    
    /*func date2number() -> (year: String?, month: String?, day: String?, hour: String?, minth: String?, second: String?) { //
    
        let subtime = self.componentsSeparatedByString(" ")
        
        let fistTime = subtime.first
        
        let lasttime = subtime.last
        
        let year = fistTime?.componentsSeparatedByString("-")[0]
        
        let month = fistTime?.componentsSeparatedByString("-")[1]
        
        let day = fistTime?.componentsSeparatedByString("-")[2]
        
        let hour = lasttime?.componentsSeparatedByString(":")[0]
        
        let minth = lasttime?.componentsSeparatedByString(":")[1]
        
        let second = lasttime?.componentsSeparatedByString(":")[2]
        
        
        return (year, month, day, hour, minth, second)
    
    }*/
    
    
    func isYear() -> Bool {
        
        let calendar = NSCalendar.currentCalendar()
        
        let nowyear = calendar.component(NSCalendarUnit.Year, fromDate: NSDate())
        
        let create = NSDateFormatter()
        
        create.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let fromDate = create.dateFromString(self)
        
        let selYear = calendar.component(NSCalendarUnit.Year, fromDate: fromDate!)
        
        print("是不是同一年\(nowyear == selYear)")
        
        return nowyear == selYear
        
    }
    
    func isToday() -> Bool {
        
        let nowdate = NSDate()
        
        let create = NSDateFormatter()
        
        create.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let nowString = create.stringFromDate(nowdate)
        
        let nowymd = nowString.componentsSeparatedByString(" ").first
        
        let sefString = self.componentsSeparatedByString(" ").first
        
        print("是\(nowymd)不\(self)是同\(sefString)一天\((nowymd! as NSString).isEqualToString(sefString!))")
        
        return (nowymd! as NSString).isEqualToString(sefString!)
        
        
    }
    
    func isYesterday() -> Bool {
        
        let nowDate = NSDate()
        
        let yearca = nowDate.equalDate(self).year
        
        let monthca = nowDate.equalDate(self).month
        
        let dayca = nowDate.equalDate(self).day
        
        print("是不是同昨天\(yearca) == 0 && \(monthca) == 0 \(dayca)&&  == 1)")
        
        return yearca == 0 && monthca == 0 && dayca == 1
    }
    

}
