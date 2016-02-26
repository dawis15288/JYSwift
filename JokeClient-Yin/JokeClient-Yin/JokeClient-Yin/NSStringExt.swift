//
//  NSStringExt.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import UIKit

extension String {
    
    func stringheightWith(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        
        let font = UIFont.systemFontOfSize(fontSize)
        
        let size = CGSizeMake(width, CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .ByWordWrapping
        
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return rect.size.height
    
    
    }
    
    
    func dateStringFromTimestamp(timeStamp: NSString) -> String {
    
        let ts = timeStamp.doubleValue
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        
        let date = NSDate(timeIntervalSince1970: ts)
        
        return formatter.stringFromDate(date)
    
    }

}
