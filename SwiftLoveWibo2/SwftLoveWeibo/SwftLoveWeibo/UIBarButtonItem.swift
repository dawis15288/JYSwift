//
//  UIToolbarCategroy.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    convenience init(imageName: String?, target: AnyObject?, action: String?) {
       
        let button = UIButton()
        
        if let imageName = imageName {
            
            button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
            
            button.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        }
        
        if let action = action {
            
            let acton = Selector(action)
            
            button.addTarget(target, action: acton, forControlEvents: UIControlEvents.TouchUpInside)
        
        }
        
        
        
        button.sizeToFit()
        
        self.init(customView: button)
    
    }

}
