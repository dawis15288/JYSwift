//
//  StatusForwardCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/18.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusForwardCell: StatusTableViewCell {
    
    override var status: Status? {
        
        didSet {
        
            if let name = status?.retweeted_Status?.user?.name {
            
                forwardLabel.text = "@\(name)"
                
            }
            
            if let text = status?.retweeted_Status?.text {
                
                recontentLabel.text = "\(text)"
                
            }
            
            
            
            
        
        }
    }

    override func setupUIs() {
        
        super.setupUIs()
        
        contentView.insertSubview(forwardButton, belowSubview: pictureView)
        
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton)
        
        contentView.insertSubview(reverifiedView, aboveSubview: forwardButton)
        
        contentView.insertSubview(recontentLabel, aboveSubview: forwardButton)
        
        forwardButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x: -10, y: 10))
        
        forwardButton.xmg_AlignVertical(type: XMG_AlignType.TopRight, referView: footerView, size: nil)
        
        forwardLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: forwardButton, size: nil, offset: CGPoint(x: 10, y: 10))
        
        reverifiedView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: forwardLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 5, y: -2))
        
        recontentLabel.xmg_AlignVertical(type: .BottomLeft, referView: forwardLabel, size: nil, offset: CGPoint(x: 0, y: 5))
        
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: recontentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: .Width)
        
        pictrueHeightCons = pictureView.xmg_Constraint(cons, attribute: .Height)
        
        pictrueTopCons = pictureView.xmg_Constraint(cons, attribute: .Top)
    }
    
    private lazy var forwardLabel: UILabel = {
        
        let lb = UILabel.createLabel(UIColor.darkGrayColor(), font: 11)
        
        lb.numberOfLines = 0
        
        lb.textColor = UIColor.redColor()
        
        lb.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        
        return lb
        
    }()
    
    private lazy var reverifiedView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.image = UIImage(named: "avatar_enterprise_vip")
        
        return iv
    
    }()
    
    private lazy var recontentLabel: UILabel = {
    
    
        let lb = UILabel.createLabel(UIColor.darkGrayColor(), font: 15)
        
        lb.numberOfLines = 0
        
        lb.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        
        return lb
    
    
    }()
    
    
    
    private lazy var forwardButton: UIButton = {
        
        let btn = UIButton()
        
        btn.backgroundColor = UIColor.grayColor()
        
        return btn
        
    }()
}
