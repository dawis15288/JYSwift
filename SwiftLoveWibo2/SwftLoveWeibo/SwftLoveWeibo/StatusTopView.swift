//
//  StatusTopView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusTopView: UIView {
    
   

    var status: Status? {
        
        didSet {
            //print("\(status?.user)\n\n\n")
    
            
            
            nameLabel.text = status!.user!.name
            
            timeLabel.text = "刚刚"
            
            sourceLabel.text = "来自: JYClient"
            
            verifiedView.image = status?.user?.verified_img
            
            vipView.image = status?.user?.membrImage
            
            sourceLabel.text = status?.source
            
            timeLabel.text = status?.created_at
            
            if let imageURL = status?.user?.imageURL {
                
                self.iconView.sd_setImageWithURL(imageURL)
                
                
            }
    
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIS()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIS() {
        
        
        addSubview(iconView)
        
        addSubview(verifiedView)
        
        addSubview(nameLabel)
        
        addSubview(vipView)
        
        addSubview(timeLabel)
        
        addSubview(sourceLabel)
        
        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
        
        
        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 5, y: 5))
        
        
        
        nameLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        
        
        vipView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 10, y: 0))
        
        
        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        
        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
    
    }
    
    // MARK: -设置各种控件
    
    private var iconView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "avatar_default_big")
        
        return iv
        
    }()
    
    private var verifiedView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "avatar_enterprise_vip")
        
        return iv
        
    }()
    
    private var nameLabel: UILabel = UILabel.createLabel(UIColor.darkGrayColor(), font: 14)
    
    
    
    private var vipView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "common_icon_membership")
        
        return iv
        
    }()
    
    private var timeLabel: UILabel = UILabel.createLabel(UIColor.orangeColor(), font: 14)
    
    private var sourceLabel: UILabel = UILabel.createLabel(UIColor.darkGrayColor(), font: 14)
}
