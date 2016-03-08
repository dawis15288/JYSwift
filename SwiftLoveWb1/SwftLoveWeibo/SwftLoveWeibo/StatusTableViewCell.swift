//
//  StatusTableViewCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    var status: Status? {
    
        didSet {
            
            //print("\(status?.user)\n\n\n")
            
            nameLabel.text = status!.user!.name
            
            timeLabel.text = "刚刚"
            
            sourceLabel.text = "来自: JYClient"
            
            contentLabel.text = status!.text
            
            if let imageURL = status?.user?.imageURL {
                
                let request = NSURLRequest(URL: imageURL)
                
                let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                
                let task = session.dataTaskWithRequest(request, completionHandler: { [ unowned self ] (data, response, error) -> Void in
                    
                    if response != nil {
                        
                        if (response as! NSHTTPURLResponse).statusCode == 200 {
                            
                            
                            
                            if let data = data {
                                
                                dispatch_async(dispatch_get_main_queue(), {  () -> Void in
                                    
                                    self.iconView.image = UIImage(data: data)
                                    
                                })
                                
                            }
                            
                        }
                        
                    }
                    
                    })
                
                task.resume()
            
            }
        
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIs() {
        
        addSubview(iconView)
        
        addSubview(verifiedView)
        
        addSubview(nameLabel)
        
        addSubview(vipView)
        
        addSubview(timeLabel)
        
        addSubview(sourceLabel)
        
        addSubview(contentLabel)
        
        iconView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: self, size: CGSize(width: 35, height: 35), offset: CGPoint(x: 10, y: 10))
        
        verifiedView.JY_AlignInner(type: JY_AlignType.BottmRight, referView: iconView, size: nil, offset: CGPoint(x: 5, y: 5))
        
        nameLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        vipView.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: nameLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        timeLabel.jy_AlignHoruizonl(type: JY_AlignType.BottmRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        sourceLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        contentLabel.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 10))
        
        contentLabel.JY_AlignInner(type: JY_AlignType.BottmRight, referView: self, size: nil, offset: CGPoint(x: -10, y: -10))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    private var contentLabel: UILabel = {
    
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(15)
        
        label.textColor = UIColor.darkGrayColor()
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - CGFloat(2 * 10)
        
        return label
    
    }()
}
