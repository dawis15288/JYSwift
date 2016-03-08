//
//  UIBarButtonItem+Category.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func crateBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: btn)
    
    }


}
