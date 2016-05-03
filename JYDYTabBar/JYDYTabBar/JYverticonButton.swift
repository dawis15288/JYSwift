//
//  JYverticonButton.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYverticonButton: UIButton {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        return CGRect(x: 5, y: 5, width: 72, height: 72)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let width = self.frame.size.width - 25
        
        return CGRect(x: 20, y: 80, width: width, height: 25)
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
