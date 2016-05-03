//
//  JYRecommenCell.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYRecommenCell: UITableViewCell {
    
    
    
    override var frame: CGRect {
        
        get {
            
            return super.frame
            
        }
        
        set(newframe) {
            
            let width = self.contentView.frame.size.width
            
            let height = self.contentView.frame.size.height
            
            let x = self.contentView.frame.origin.x + 3
            
            self.contentView.frame = CGRect(x: x, y: self.contentView.frame .origin.y - 5, width: width - x , height: height - 3)
            
            self.frame = CGRect(x: x, y: self.frame.origin.y - 5, width: width - x , height: height - 3)
            
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y + 10, width: frame.size.width, height: frame.size.height)
            
        }
        
    }
    
    var recmmen: Recommends? {
        
        didSet {
        
            jyLabel1.text = recmmen!.theme_name
            
            if  let sub_number = Double(recmmen!.sub_number!) {
            
                if sub_number < 10000	 {
                    
                    self.jyLabel2.text = "\(recmmen!.sub_number!)人订阅"
                    
                } else {
                    
                    let subNumber = sub_number / 10000.0
                    
                    self.jyLabel2.text = "\(subNumber)万人订阅"
                    
                }
            }
            
            
            
            
            
            BudejieNetTool.loadThememage(recmmen!.image_list) { (data, errr) in
                
                if data != nil && errr == nil {
                    
                    self.jyImageView.image = UIImage(data: data!)
                    
                }
                
            }
            
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        
        
        self.selectionStyle = .None
        
        setupU()
        
    }
    
    private func setupU() {
        
        contentView.addSubview(jyImageView)
        
        contentView.addSubview(jyButton)
        
        contentView.addSubview(jyLabel1)
        
        contentView.addSubview(jyLabel2)
        
        jyImageView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: 60, height: 60), offset: CGPoint(x: 10, y: 10))
        
        jyLabel1.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: jyImageView, size: nil, offset: CGPoint(x: 10, y: 0))
        
       jyLabel2.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: jyImageView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        let y = (contentView.frame.size.height - jyButton.frame.size.height) / 2.0
        
        jyButton.xmg_AlignInner(type: XMG_AlignType.TopRight, referView: contentView, size: nil, offset: CGPoint(x: -10, y: y))
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.size.width
        
        let height = self.frame.size.height
        
        let x = self.frame.origin.x
        
        self.frame = CGRect(x: 5, y: self.frame.origin.y, width: width - x , height: height - 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private lazy var jyImageView: UIImageView = {
        
        let mageView = UIImageView()
        
        mageView.image = UIImage(named: "defaultUserIcon")
        
        return mageView
    
    }()
    
    private lazy var jyButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("+ 关注", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        
        button.addTarget(self, action: #selector(addFollow), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        
    }()
    
    func addFollow() {
    }
    
    private lazy var jyLabel1: UILabel = {
        
        let abel = UILabel()
        
        abel.font = UIFont.systemFontOfSize(16)
        
        abel.textColor = UIColor.grayColor()
        
        return abel
        
    }()
    
    private lazy var jyLabel2: UILabel = {
        
        let abel = UILabel()
        
        abel.font = UIFont.systemFontOfSize(16)
        
        abel.textColor = UIColor.grayColor()
        
        return abel
        
    }()

}
