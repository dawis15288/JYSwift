//
//  StatusTableViewCell.swift
//  JokeClient-Yin
//
//  Created by atom on 16/4/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    var largeImageURL: String?
    
    var pictureWidthCons: NSLayoutConstraint?
    
    var pictrueHeightCons: NSLayoutConstraint?
    
    var pictrueTopCons: NSLayoutConstraint?
    
    var data: Statues? {
        
        didSet {
            
            if let content = data!.content {
            
                self.contentTF.text = content
            }
            
            if let image = data!.image {
                
                if image.characters.count == 0 {
                    
                    //self.pictureView.hidden = true
                    
                } else {
                    
                    let  imageID = "\(data!.id)"
                    
                    let prefiximageID = ( imageID as NSString ).substringToIndex(imageID.characters.count - 4)
                    
                    let imageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/small/\(image)"
                    
                    //self.pictureView.hidden = false
                    
                    self.pictureView.setImage(imageURL, placeHolder: UIImage(named: "avatar.jpg"))
                    
                    self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/medium/\(image)"
                    
                
                }
            
            }
            
            topView.topstatus = data!
            
            footerView.footerStatus = data!
        
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupUIs()
        
    
    }
    
    private func setupUIs() {
        
        contentView.addSubview(topView)
        
        contentView.addSubview(contentTF)
        
        contentView.addSubview(pictureView)
        
        contentView.addSubview(footerView)
        
        let wdth = UIScreen.mainScreen().bounds.width
        
        //topView.JY_AlignInner()
        
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: wdth, height: 60))
        
        contentTF.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: 10, y: 10))
        
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentTF, size: CGSize(width: 60, height: 60), offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: .Width)
        
        pictrueHeightCons = pictureView.xmg_Constraint(cons, attribute: .Height)
        
        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: wdth, height: 44), offset: CGPoint(x: -10, y: 10))
    
    }
    
    func rowHeights(status: Statues) -> CGFloat {
        
        self.data = status
        
        self.layoutIfNeeded()
        
        return CGRectGetMaxY(footerView.frame)
        
    }
    
    private var topView: StatusTopView = StatusTopView()
    
   
    
    
    private lazy  var   pictureView: UIImageView = {
    
        let imageView = UIImageView()
        
        
        return imageView
    
    }()
    
    
    private lazy  var  contentTF: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(15)
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        
        return label
    
    }()
    
    
   var  footerView: BottomView = BottomView()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

}
