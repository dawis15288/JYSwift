//
//  JYBottomView.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYBottomView: UIView {
    
    var topic: JYTopics? {
        
        didSet {
            
            if let hate = topic!.hate, love = topic!.love, reponst = topic!.repost, commetnt = topic!.comment {
                
                self.hateButton.jy_settitle(Int(hate), placehodler: "踩")
                
                self.loveButton.jy_settitle(Int(love), placehodler: "赞")
                
                self.rtButton.jy_settitle(Int(reponst), placehodler: "转发")
                
                self.commentButton.jy_settitle(Int(commetnt), placehodler: "评论")
            
            }
        
           
        
        }
    
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIs()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUIs() {
    
        self.addSubview(loveButton)
        
        self.addSubview(hateButton)
        
        self.addSubview(rtButton)
        
        self.addSubview(commentButton)
        
        xmg_HorizontalTile([loveButton, hateButton, rtButton, commentButton], insets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        
        
    
    }
    
    private lazy var hateButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        button.setImage(UIImage(named: "mainCellCai"), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        return button
        
    }()
    
    private lazy var loveButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        
        button.setImage(UIImage(named: "mainCellDing"), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        return button
        
    }()
    
    private lazy var rtButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        
        
        button.setImage(UIImage(named: "mainCellShare"), forState: UIControlState.Normal)
        
        return button
        
    }()
    
    private lazy var likeButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        return button
        
    }()
    
    private lazy var commentButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        button.setImage(UIImage(named: "mainCellComment"), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        return button
        
    }()

}
