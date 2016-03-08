//
//  TitleButton.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
       
        super.init(frame: frame)
        
        self.setTitleColor(UIColor.darkTextColor(), forState: UIControlState.Normal)
        
        self.titleLabel?.font = UIFont.systemFontOfSize(17)
        
        self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        
        self.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Highlighted)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = titleLabel!.frame.size.width
        
    }

}
