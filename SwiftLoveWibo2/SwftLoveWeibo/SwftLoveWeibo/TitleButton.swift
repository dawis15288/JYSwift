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
        
        //setTitle("首页  ", forState: UIControlState.Normal)
        
        //self.tag = 99
        
        
 
        if let user = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String {
            
            self.setTitle("\(user)  ", forState: .Normal)
            
            self.tag = 11
            
            self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
            
            //原来不是设置高亮，而是设置状态为Selected，就能显示箭头朝上，而高亮是在点击button那一刻，松开结束了！
            
            self.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
            
            self.sizeToFit()
            
        }
        
        
        
        
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
