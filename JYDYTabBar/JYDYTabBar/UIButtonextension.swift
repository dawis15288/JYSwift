//
//  UIButtonextension.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIButton {


    func jy_settitle(count: Int?, placehodler: String?) {
        
        if count > 10000 {
            
            self.setTitle("\(count! / 10000)万", forState: UIControlState.Normal)
         
        } else if count == 0 {
        
            
            self.setTitle(placehodler!, forState: UIControlState.Normal)
        
        } else {
            
            self.setTitle("\(count!)", forState: UIControlState.Normal)
        
        }
        
        
        
        
    }

}
