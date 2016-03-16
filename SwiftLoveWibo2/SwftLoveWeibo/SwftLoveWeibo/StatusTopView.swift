//
//  StatusTopView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusTopView: UIView {
    
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
    
    private var nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(14)
        
        label.textColor = UIColor.darkGrayColor()
        
        return label
        
    }()
    
    private var vipView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "common_icon_membership")
        
        return iv
        
    }()
    
    private var timeLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(10)
        
        label.textColor = UIColor.orangeColor()
        
        return label
        
    }()
    
    private var sourceLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(10)
        
        label.textColor = UIColor.darkGrayColor()
        
        return label
        
    }()

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
    
        
        iconView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: self, size: CGSize(width: 25, height: 25), offset: CGPoint(x: 10, y: 10))
        
        verifiedView.JY_AlignInner(type: JY_AlignType.BottmRight, referView: iconView, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 5, y: 5))
        
        nameLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        vipView.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: nameLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 10, y: 0))
        
        timeLabel.jy_AlignHoruizonl(type: JY_AlignType.BottmRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        sourceLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        
    
    }
}
