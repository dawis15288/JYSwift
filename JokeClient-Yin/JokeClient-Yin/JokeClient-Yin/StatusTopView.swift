//
//  StatusTopView.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusTopView: UIView {
    
    var topstatus: Statues? {
        
        didSet {
            
            if let user = topstatus!.user {
                
                
                if let login = user.login {
                    
                    self.nickLabel.text = login
                    
                    let userID = String(user.id)
                    
                    let prefixUserID = ( userID as NSString ).substringToIndex( userID.characters.count - 4 )
                    
                    if let userIcon = user.icon {
                        
                        let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserID)/\(userID)/medium/\(userIcon)"
                        
                        self.avatarView.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
                        
                    }
                    
                } else {
                    
                    self.avatarView.image = UIImage(named: "avatar.jpg")
                    
                    self.nickLabel.text = "匿名"
                    
                }
                
                
            }
        
        
        }
        
        
    
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIS()
    }
    
    func setupUIS() {
        
        addSubview(avatarView)
        
        addSubview(nickLabel)
        
        avatarView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
        nickLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: avatarView, size: nil, offset: CGPoint(x: 10, y: 0))
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy  var   avatarView: UIImageView = {
        
        let imageView = UIImageView()
        
        
        
        return imageView
        
    }()
    
    private lazy  var  nickLabel: UILabel = {
        
        let label = UILabel()
        
        
        return label
        
    }()

}
