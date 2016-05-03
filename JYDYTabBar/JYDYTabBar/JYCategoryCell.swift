//
//  JYCategoryCellTableViewCell.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCategoryCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.backgroundColor = UIColor.whiteColor()
    
        self.contentView.addSubview(JYiew)
        
        JYiew.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width:3, height: 64 ))
        
        //设置为None textLabel不会进入高亮状态
        
        self.textLabel?.frame.origin.y = 2
        
        self.textLabel?.frame.size.height = self.contentView.frame.size.height - 2 * (self.textLabel?.frame.origin.y)!
        
        self.selectionStyle = .None
        
        self.backgroundColor = UIColor.clearColor()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        
        JYiew.hidden = !selected
        
        //设置为None textLabel不会进入高亮状态 只需要设置textColor就行了
        
        self.textLabel?.textColor = selected ? UIColor.redColor() : UIColor.grayColor()
        
    }
    
    private lazy var JYiew: UIView = {
        
         let view = UIView()
        
        view.backgroundColor = UIColor.redColor()
        
        return view
    
    }()

}
