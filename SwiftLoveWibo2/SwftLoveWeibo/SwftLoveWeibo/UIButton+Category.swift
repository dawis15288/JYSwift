//
//  UIButton+Category.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIButton {

    class func createButton(imageName: String, title: String) -> UIButton {
    
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), forState: .Normal)
        
        button.setTitle(title, forState: .Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
        
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        return button
    }

}