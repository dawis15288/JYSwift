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
    
    var widthCons: NSLayoutConstraint?
    
    var heightCons: NSLayoutConstraint?
    
    var status: Status? {
    
        didSet {
            
            //print("\(status?.user)\n\n\n")
            
            nameLabel.text = status!.user!.name
            
            timeLabel.text = "刚刚"
            
            sourceLabel.text = "来自: JYClient"
            
            contentLabel.text = status!.text
            
            verifiedView.image = status?.user?.verified_img
            
            vipView.image = status?.user?.membrImage
            
            sourceLabel.text = status?.source
            
            timeLabel.text = status?.created_at
            
            let size = calculateimagSize(status!)
            
            widthCons?.constant = size.viewSize.width
            
            heightCons?.constant = size.viewSize.height
            
            if size.itemSize == CGSizeZero {
                
                layout.itemSize = size.itemSize
            
            }
            
            pictureView.reloadData()
            
            if let imageURL = status?.user?.imageURL {
                
                self.iconView.sd_setImageWithURL(imageURL)
                
                /*let request = NSURLRequest(URL: imageURL)
                
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
                
                task.resume()*/
            
            }
        
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIs()
        
        preparePictureView()
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
        
        addSubview(pictureView)
        
       addSubview(footerView)
        
        
        //footerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        iconView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: self, size: CGSize(width: 35, height: 35), offset: CGPoint(x: 10, y: 10))
        
        verifiedView.JY_AlignInner(type: JY_AlignType.BottmRight, referView: iconView, size: nil, offset: CGPoint(x: 5, y: 5))
        
        nameLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        vipView.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: nameLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        timeLabel.jy_AlignHoruizonl(type: JY_AlignType.BottmRight, referVuew: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        sourceLabel.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        contentLabel.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 10))
        
        //contentLabel.JY_AlignInner(type: JY_AlignType.BottmRight, referView: self, size: nil, offset: CGPoint(x: -10, y: -10))
        
        let cons = pictureView.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: contentLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 10))
        
        //pictureView.JY_AlignInner(type: JY_AlignType.BottmRight, referView: contentView, size: nil, offset: CGPoint(x: -10, y: -10))
        
        widthCons = pictureView.jy_Constraint(cons, attribute: .Width)
        
        heightCons = pictureView.jy_Constraint(cons, attribute: .Height)
        
        let width = UIScreen.mainScreen().bounds.width
        
        //footerView.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: contentLabel, size: CGSize(width: width, height: 44), offset: CGPoint(x: -10, y: 10))
        
        //footerView.JY_AlignInner(type: JY_AlignType.BottmRight, referView: contentView, size: nil, offset: CGPoint(x: -10, y: -10))
        
        footerView.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: pictureView, size: CGSize(width: width, height: 44), offset: CGPoint(x: -10, y: 10))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: -处理微博中的图片
    /*
    0.没有图片, 返回zero
    1.单张图片, 返回图片实际大小
    2.多张图片, 图片大小固定
    2.1四张图片, 会按照田字格显示
    2.2其它多图, 按照九宫格显示
    */
    
    private func calculateimagSize(status: Status) -> (viewSize: CGSize, itemSize: CGSize) {
    
        if let count = status.stordPictureURLs?.count {
            
            if count == 0 {
                
                return (CGSizeZero, CGSizeZero)
                
            }
            
            if count == 1 {
                
                let key = status.stordPictureURLs?.first?.absoluteString
                
                let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
                
                return (image.size, image.size)
                
            }
            
            let itemSize = CGSize(width: 90, height: 90)
            
            let margin: CGFloat = 10
            
            if count == 4 {
                
                let width = itemSize.width * CGFloat(2) + margin
                
                return (CGSize(width: width, height: width), itemSize)
                
                
            }
            
            let colCount = 3
            
            let rowCount = (count - 1) / 3 + 1
            
            let width = itemSize.width * CGFloat(colCount) + CGFloat(colCount - 1) * margin
            
            let height = itemSize.height * CGFloat(rowCount) + CGFloat(rowCount - 1) * margin
            
            return (CGSize(width: width, height: height), itemSize)
        
        }
        
        return (CGSizeZero, CGSizeZero)
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
    
    private lazy var layout = UICollectionViewFlowLayout()
    
    private lazy var pictureView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
    
    private lazy var footerView: StatusFooterView = StatusFooterView()
    
    // MARK: 配图视图
    
    private func preparePictureView() {
        
        pictureView.registerClass(StatusPictureCell.self, forCellWithReuseIdentifier: JYPictureCellReuseIdentifier)
        
        pictureView.dataSource = self
        
        pictureView.backgroundColor = UIColor.lightGrayColor()
        
        layout.minimumInteritemSpacing = 10
        
        layout.minimumLineSpacing = 10
    }
    
    // MARK: footer视图
    
    private lazy var footrView: StatusFooterView = {
        
        let fv = StatusFooterView()
        
        fv.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        return fv
    
    }()
}


class StatusFooterView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder aDecoder: NSCoder)")
    }
    
    private func setupUI() {
        
        addSubview(retweetButton)
        
        addSubview(unLikeButton)
        
        addSubview(commonButton)
        
        //jy_HorizontalTitle([retweetButton, unLikeButton, commonButton], insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        jy_HorizontalTitle([retweetButton, commonButton, unLikeButton], insets: UIEdgeInsetsZero)
    }
    
    private lazy var retweetButton: UIButton = {
    
        let button = UIButton()
        
        button.setImage(UIImage(named: "timeline_icon_retweet"), forState: .Normal)
        
        button.setTitle("转发", forState: .Normal)
        
        return button
    
    }()
    
    private lazy var unLikeButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("赞", forState: .Normal)
        
        button.setImage(UIImage(named: "timeline_icon_unlike"), forState: .Normal)
    
        return button
    }()
    
    private lazy var commonButton: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "timeline_icon_comment"), forState: .Normal)
        
        button.setTitle("评论", forState: .Normal)
        
        return button
    
    }()
}

private class StatusPictureCell: UICollectionViewCell {
    
    private lazy var iconView = UIImageView()
    
    var imageURL: NSURL? {
        
        didSet {
            
            iconView.sd_setImageWithURL(imageURL!)
        
        }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(iconView)
        
        iconView.JY_Fill(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init?(coder aDecoder: NSCoder)没有实现")
    }
}

extension StatusTableViewCell: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return status?.stordPictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCellWithReuseIdentifier(JYPictureCellReuseIdentifier, forIndexPath: indexPath) as! StatusPictureCell
        
        itemCell.imageURL = status?.stordPictureURLs![indexPath.row]
        
        return itemCell
    }
}

