//
//  NewfeatureCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class NewfatureCll: UICollectionViewCell {
    
    private lazy var iconView = UIImageView()
    
    private lazy var startButton: UIButton = {
        
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
        
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
        
        button.setTitle("开始体验", forState: .Normal)
        
        button.sizeToFit()
        
        button.addTarget(self, action: "startWeibo:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    func startWeibo(sender: UIButton) {
        
       NSNotificationCenter.defaultCenter().postNotificationName(JYRootViewControllerSwitchNotification, object: true)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(iconView)
        
        contentView.addSubview(startButton)
        
        iconView.JY_Fill(contentView)
        
        startButton.jy_AlignVertical(type: JY_AlignType.BottomCenter, referView: contentView, size: nil, offset: CGPoint(x: 0, y: -160))
        
    }
    
    var imageIndex: Int = 0 {
        
        didSet {
            
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            startButton.hidden = true
        }
        
    }
    
    func startAnimation() {
        
        startButton.hidden = false
        
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        startButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(1.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            self.startButton.transform = CGAffineTransformIdentity
            
            }, completion: { (finish) -> Void in
                
                self.startButton.userInteractionEnabled = true
        })
        
    }
}
