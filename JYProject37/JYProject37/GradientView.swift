//
//  GradientView.swift
//  JYProject37
//
//  Created by atom on 16/2/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var bottomColor: UIColor = UIColor.blackColor()
    
    override class func layerClass() -> AnyClass {
    
        return CAGradientLayer.self
    
    }
    
    override func layoutSubviews() {
        
        (layer as! CAGradientLayer).colors = [topColor.CGColor, bottomColor.CGColor]
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
