//
//  StatusBottomView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusBottomView: UIView {
    
    var bttmstatus: [String: Int]? {
        
        didSet {
            
            if bttmstatus!["reposts_count"]! > 0 {
                
                    retweetButton.setTitle("\(bttmstatus!["reposts_count"]!)", forState: UIControlState.Normal)
                }
                
                
            if bttmstatus!["comments_count"] > 0 {
            
                commonButton.setTitle("\(bttmstatus!["comments_count"]!)", forState: UIControlState.Normal)
            
            }
                
                    
            if bttmstatus!["attitudes_count"] > 0 {
            
                unLikeButton.setTitle("\(bttmstatus!["attitudes_count"]!)", forState: UIControlState.Normal)
                
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
        
        //backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        addSubview(retweetButton)
        
        addSubview(unLikeButton)
        
        addSubview(commonButton)
        
        xmg_HorizontalTile([retweetButton, commonButton, unLikeButton], insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    private lazy var retweetButton: UIButton = {
    
        let buttn = UIButton.createButton("timeline_icon_retweet", title: "转发")
        
        buttn.addTarget(self, action: #selector(retweet), forControlEvents: UIControlEvents.TouchUpInside)
        
        return buttn
    
    }()
    
    
    private lazy var commonButton: UIButton = {
        
        let buttn = UIButton.createButton("timeline_icon_comment", title: "评论")
        
        buttn.addTarget(self, action: #selector(comment), forControlEvents: UIControlEvents.TouchUpInside)
        
        return buttn
        
    }()
    
    //
    
    private lazy var unLikeButton: UIButton = {
        
        let buttn = UIButton.createButton("timeline_icon_unlike", title: "赞")
        
        buttn.addTarget(self, action: #selector(unlike), forControlEvents: UIControlEvents.TouchUpInside)
        
        return buttn
        
    }()
    
    func retweet() {
        
        #function
        
    }
    
    func comment() {
        #function
        
    }
    
    func unlike() {
        #function
        
    }
    
    

}
