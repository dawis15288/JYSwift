//
//  StatusTableViewCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SDWebImage

let JYPictureCellReuseIdentifier = "JYPictureCellReuseIdentifier"

class StatusTableViewCell: UITableViewCell {
    
    var pictureWidthCons: NSLayoutConstraint?
    
    var pictrueHeightCons: NSLayoutConstraint?
    
    var topCons: NSLayoutConstraint?
    
    var status: Status? {
    
        didSet {
            
            topView.status = status
            
            contentLabel.text = status!.text
            
            pictureView.status = status
            
            //let size = pictureView.calculateImageSize()
            
            pictureWidthCons?.constant = pictureView.bounds.size.width
            
            pictureWidthCons?.constant = pictureView.bounds.size.height
            
            topCons?.constant = (pictureView.bounds.size.height == 0) ? 0 : 10
            
            pictureView.reloadData()
        
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
        
        addSubview(topView)
        
        addSubview(contentLabel)
        
        addSubview(pictureView)
        
        addSubview(footerView)
        
        let width = UIScreen.mainScreen().bounds.width
        
        topView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: contentView, size: CGSize(width: width, height: 35))
        
         contentLabel.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: topView, size: nil, offset: CGPoint(x: 5, y: 10))
        
        let cons =  pictureView.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.jy_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        pictrueHeightCons = pictureView.jy_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
        topCons = pictureView.jy_Constraint(cons, attribute: NSLayoutAttribute.Top)
        
        
        footerView.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: pictureView, size: CGSize(width: width, height: 44), offset: CGPoint(x: -10, y: 10))
    }
    
    // MARK: -计算行高
    
    func rowHeight(status: Status) -> CGFloat {
        
        self.status = status
        
        self.layoutIfNeeded()
        
        return CGRectGetMaxY(footerView.frame)
    
    }
    
    
   
    
    // MARK: -设置各种控件
    
    private var topView: StatusTopView = StatusTopView()
    
    private var contentLabel: UILabel = {
    
        let label = UILabel(color:UIColor.darkGrayColor(), fontSize: 15)
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        
        return label
    
    }()
    
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    
    // MARK: footer视图
    
    private lazy var footerView: StatusBottomView = StatusBottomView()
    
     // MARK: header视图
    
    private lazy var headerView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        return view
    
    }()
}



