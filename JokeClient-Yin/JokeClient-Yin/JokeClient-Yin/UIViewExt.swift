//
//  UIViewExt.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    
    func setY(y: CGFloat) {
        
        var rect: CGRect = self.frame
        
        rect.origin.y = y
        
        self.frame = rect
    
    }

    func setHeight(height: CGFloat) {
        
        var rect: CGRect = self.frame
        
        rect.size.height = height
        
        self.frame = rect
    
    }
    
    func bottom() -> CGFloat {
        
        return self.frame.origin.y + self.frame.size.height
    
    }
    
    class func showAlertView(title: String, message: String) -> UIAlertController {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (acton: UIAlertAction) -> Void in
            
            print("error loading")
        
        }))
        
         return ac
    
    }

}
