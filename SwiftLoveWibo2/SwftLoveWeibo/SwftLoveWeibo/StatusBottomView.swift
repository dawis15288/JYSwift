//
//  StatusBottomView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusBottomView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIs() {
        
        backgroundColor = UIColor(white: 0.2, alpha: 1)
    
        addSubview(retweetButton)
        
        addSubview(unLikeButton)
        
        addSubview(commonButton)
        
        jy_HorizontalTitle([retweetButton, commonButton, unLikeButton], insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    private lazy var retweetButton: UIButton = UIButton.createButton("timeline_icon_retweet", title: "转发")
    
    private lazy var unLikeButton: UIButton = UIButton.createButton("timeline_icon_unlike", title: "赞")
    
    private lazy var commonButton: UIButton = UIButton.createButton("timeline_icon_comment", title: "评论")

}
