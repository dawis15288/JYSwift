//
//  JYCategoryUserCellTableViewCell.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/25.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCategoryUserCell: UITableViewCell {
    
    var categoryUser: CategoryUser? {
        
        didSet {
            
            BudejieNetTool.loadThememage(categoryUser!.header) { (data, errr) in
                
                if data != nil && errr == nil {
                    
                    self.jyImageView.image = UIImage(data: data!)
                    
                }
                
            }
            
            self.jyLabel1.text = categoryUser!.screen_name
            
            self.jyLabel2.text = categoryUser!.fans_count
        
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupUi()
    
    }
    
    private func setupUi() {
        
        self.selectionStyle = .None
        
        
        contentView.addSubview(jyImageView)
        
        contentView.addSubview(jyButton)
        
        contentView.addSubview(jyLabel1)
        
        contentView.addSubview(jyLabel2)
        
        jyImageView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let width = self.frame.size.width
        
        let height = self.frame.size.height
        
        let x = self.frame.origin.x
        
        let y = self.frame.origin.y
        
        self.frame = CGRect(x: x, y: y, width: width , height: height - 3)
        
        
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
        
        abel.font = UIFont.systemFontOfSize(13)
        
        abel.textColor = UIColor.grayColor()
        
        return abel
        
    }()
    
    private lazy var jyLabel2: UILabel = {
        
        let abel = UILabel()
        
        abel.font = UIFont.systemFontOfSize(11)
        
        abel.textColor = UIColor.grayColor()
        
        return abel
        
    }()

}
