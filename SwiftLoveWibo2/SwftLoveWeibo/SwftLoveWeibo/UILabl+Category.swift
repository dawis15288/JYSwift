//
//  UILabl+Category.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(color: UIColor, fontSize: CGFloat) {
        
        self.init()
        
        textColor = color
        
        font = UIFont.systemFontOfSize(fontSize)
    }

}
