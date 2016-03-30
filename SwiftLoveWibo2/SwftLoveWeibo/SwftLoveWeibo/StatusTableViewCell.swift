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
    
    var pictrueTopCons: NSLayoutConstraint?
    
    var status: Status? {
    
        didSet {
            
            topView.status = status
            
            
            contentLabel.text = status!.text
            
            pictureView.status = status!.retweeted_Status != nil ? status!.retweeted_Status! : status
            
            //设置配图尺寸
            
           let size = pictureView.calculateImageSize()
            
            
            
            pictureWidthCons?.constant = size.viewSize.width
            
            
            
            pictrueHeightCons?.constant = size.viewSize.height
            
            pictrueTopCons?.constant = size.viewSize.height == 0 ? 0 : 10
            
            
        
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIs()
        
        //setupPicture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIs() {
        
        contentView.addSubview(topView)
        
        contentView.addSubview(contentLabel)
        
        contentView.addSubview(pictureView)
        
       contentView.addSubview(footerView)
        
        let wdth = UIScreen.mainScreen().bounds.width
        
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: wdth, height: 60))
        
        
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: 10, y: 10))

        
        
        
        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: wdth, height: 44), offset: CGPoint(x: -10, y: 10))
        
        
       
    }
    
    // MARK: -计算行高
    
    func rowHeights(status: Status) -> CGFloat {
        
        self.status = status
        
        self.layoutIfNeeded()
        
        return CGRectGetMaxY(footerView.frame)
    
    }
    
   
   
    
    
    
    var contentLabel: UILabel = {
        
        let label = UILabel.createLabel(UIColor.darkGrayColor(), font: 15)//UILabel(color:UIColor.darkGrayColor(), fontSize: 15)
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        
        return label
        
    }()
    
    
    //MARK: 顶部视图
    
    private var topView: StatusTopView = StatusTopView()
    
    //private lazy var picturelayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy var pictureView: StatusPictureView = StatusPictureView()
    
    //UICollectionView(frame: CGRectZero, collectionViewLayout: self.picturelayout)
    
    //StatusPictureView()
    
    // MARK: footer视图
    
    lazy var footerView: StatusBottomView = StatusBottomView()
    
     // MARK: header视图
    
    private lazy var headerView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        return view
    
    }()
}

/*private  class StatusFooterView: UIView {
    
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
    
    private lazy var retweetButton: UIButton = UIButton.createButton("timeline_icon_unlike", title: "转发")
    
    
    private lazy var unLikeButton: UIButton = UIButton.createButton("timeline_icon_unlike", title: "赞")
    
    
    private lazy var commonButton: UIButton = UIButton.createButton("timeline_icon_comment", title: "评论")
   
    
}*/


