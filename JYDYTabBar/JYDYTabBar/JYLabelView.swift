//
//  JYLabelView.swift
//  JYTest -- 测试顶部标签视图
//
//  Created by atom on 16/4/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

protocol JJYLabelViewdelagate{
    
    func buttontitleClick(button: UIButton)
    
    
}

class JYLabelView: UIView {
        
        var buttonWidth: CGFloat?
    
    var jyIndview: UIView?
    
    var delegate: JJYLabelViewdelagate?
    
    var selectorButton: UIButton?
    
        var jyViewCons: NSLayoutConstraint?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUIs()
            
            self.titleclick(Allbutton)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUIs() {
            
            self.addSubview(Allbutton)
            
            self.addSubview(Jokebutton)
            
            self.addSubview(Videobutton)
            
            self.addSubview(Riadeobutton)
            
            self.addSubview(Picturebutton)
            
            self.addSubview(jyview)
            
            self.jyIndview = jyview
            
            
            let views = [Allbutton, Jokebutton, Videobutton, Riadeobutton, Picturebutton]
            
            self.xmg_HorizontalTile(views, insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
            
            let cons = jyview.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: self, size: CGSize(width: 30, height: 2), offset: CGPoint(x: 31.5, y: -2))
            
            
            
            jyViewCons = xmg_Constraint(cons, attribute: NSLayoutAttribute.CenterX)
            
        }
        
        private lazy var Allbutton: UIButton = {
            
            let btton = UIButton()
            
            btton.tag = 10
            
            btton.setTitle("全部", forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            btton.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            btton.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return btton
            
        }()
        
        private lazy var Jokebutton: UIButton = {
            
            let button = UIButton()
            
            button.tag = 11
            
            button.setTitle("段子", forState: UIControlState.Normal)
            
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            button.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
            
        }()
        
        private lazy var Videobutton: UIButton = {
            
            let btton = UIButton()
            
            btton.tag = 12
            
            btton.setTitle("视频", forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            btton.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            btton.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return btton
            
        }()
        
        private lazy var Riadeobutton: UIButton = {
            
            let btton = UIButton()
            
            btton.tag = 13
            
            btton.setTitle("音频", forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            btton.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            btton.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return btton
            
        }()
        
        private lazy var Picturebutton: UIButton = {
            
            let btton = UIButton()
            
            btton.tag = 14
            
            btton.setTitle("图片", forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            btton.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            btton.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return btton
            
        }()
        
        private lazy var jyview: UIView = {
            
            let view = UIView()
            
            view.backgroundColor = UIColor.redColor()
            
            view.tag = -1
            
            return view
            
        }()
        
        
        func titleclick(button: UIButton) {
            
            print(button.frame)
            
            selectorButton?.enabled = true
            
            button.enabled = false
            
            selectorButton = button
            
            UIView.animateWithDuration(0.25) { 
                
                let margin = button.frame.size.width * CGFloat(integerLiteral: button.tag - 10)
                
                let x = CGFloat(31.5)
                
                self.jyview.frame.origin.x = x + margin
                
            }
            
            self.delegate?.buttontitleClick(button)
            
        }
        
    
}
