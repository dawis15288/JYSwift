//
//  VisitorView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/8.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    override init(frame: CGRect) {
      
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(iconView)
        
        addSubview(maskIconView)
        
        addSubview(homeIconView)
        
        addSubview(messageLabel)
        
        addSubview(registerButton)
        
        addSubview(loginButton)
        
        self.backgroundColor = UIColor.whiteColor()
        
        iconView.JY_AlignInner(type: JY_AlignType.Center, referView: self, size: nil)
        
        maskIconView.JY_Fill(self)
        
        homeIconView.JY_AlignInner(type: JY_AlignType.Center, referView: self, size: nil)
        
        messageLabel.jy_AlignVertical(type: JY_AlignType.BottomCenter, referView: iconView, size: nil)
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        registerButton.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: messageLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        
        loginButton.jy_AlignVertical(type: JY_AlignType.BottmRight, referView: messageLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        
    }
    
    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return iv
        
    }()
    
    private lazy var maskIconView: UIImageView = {
    
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return iv
    
    }()
    
    private lazy var homeIconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return iv
    
    }()
    
    private lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "关注一些人，回这里看看有什么惊喜"
        
        label.textColor = UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(14)
        
        label.numberOfLines = 0
        
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var registerButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("注册", forState: .Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        
        return btn
    }()
    
    private lazy var loginButton: UIButton = {
    
        let btn = UIButton()
        
        btn.setTitle("登录", forState: .Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        
        btn.addTarget(self, action: "weiboLogin:", forControlEvents: .TouchUpInside)
        
        return btn
    
    }()
    
    func weiboLogin(sender: UIButton) {
        
        let weiboAuthor = WebViewController()
    
    }

}
