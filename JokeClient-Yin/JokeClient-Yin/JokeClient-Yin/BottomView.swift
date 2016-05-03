//
//  BottomView.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class BottomView: UIView {
    
    var footerStatus: Statues? {
        
        didSet {
            
            if let votes = footerStatus!.votes {
                
                retweet.text = "顶\(votes.up)"
                
                unLike.text = "踩\(votes.down)"
                
            } else {
                
                retweet.text = "顶(0)"
                
                unLike.text = " 踩(0)"
                
            }
            
            
            common.text = "评论\(footerStatus!.comments_count)"
        
        }
        
        
        
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIs()
    
    }
    
    private func setupUIs() {
        
        addSubview(retweet)
        
        addSubview(unLike)
        
        addSubview(common)
        
        xmg_HorizontalTile([retweet, common, unLike], insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0))
    
    }
    
    private lazy var retweet: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(13)
        
        return label
    
    }()
    
    
    private lazy var unLike: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(13)
        
        return label
        
    }()
    
    
    private lazy var common: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(13)
        
        return label
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
