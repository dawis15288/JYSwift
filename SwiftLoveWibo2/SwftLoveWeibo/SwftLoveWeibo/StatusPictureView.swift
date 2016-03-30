//
//  StatusPictureView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SDWebImage

let JYShowWeiboPictrue = "showWeiboPictrue"

let JYShowWeiboPictrueIndex = "showWeiboPictrueIndex"

let JYShowWeiboPictrueURLs = "showWeiboPictrueURLs"

class StatusPictureView: UICollectionView {

    private lazy var iconView = UIImageView()
    
    var status: Status? {
        
        didSet {
            
            sizeToFit()
            
            reloadData()
        
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        
        let size = calculateImageSize().itemSize
        
        return size
    }
    
    private var pictureLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        
        super.init(frame: CGRectZero, collectionViewLayout: pictureLayout)
        
        registerClass(PictureViewCell.self, forCellWithReuseIdentifier: JYPictureCellReuseIdentifier)
        
        dataSource = self
        
        delegate = self
        
        backgroundColor = UIColor.lightGrayColor()
        
        pictureLayout.minimumInteritemSpacing = 1
        
        pictureLayout.minimumLineSpacing = 1
        
        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init?(coder aDecoder: NSCoder)没有实现")
    }
    
    // MARK: -处理微博中的图片
    
    func calculateImageSize() -> (viewSize: CGSize, itemSize: CGSize) {
        
        let count = status?.stordPictureURLs?.count //{
        
        if count == 0 || count == nil {
            
            return (CGSize(width: 1, height: 1), CGSize(width: 1, height: 1))
            
        }
        
        /*if count == 1 {
        
        if let key = status?.stordPictureURLs!.first?.absoluteString {
        
        if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key) {
        
        
        
        return (image.size, image.size)
        
        }
        
        return (CGSize(width: 1, height: 1), CGSize(width: 1, height: 1))
        
        }
        
        //
        
        }*/
        
        let width = 120
        
        let margin = 5
        
        pictureLayout.itemSize = CGSize(width: width, height: width)
        
        if count == 4 {
            
            let viewWidth = width * 2 + margin
            
            return (CGSize(width: viewWidth, height: viewWidth), CGSize(width: width, height: width))
            
            
        }
        
        let colCount = 3
        
        let rowCount = (count! - 1) / 3 + 1
        
        let pictureWidth = colCount * width + (colCount - 1) * margin
        
        let pictureHeight = rowCount * width + (rowCount - 1 ) * margin
        
        return (CGSize(width: pictureWidth, height: pictureHeight), CGSize(width: width, height: width))
        
        
    }
    
}

extension StatusPictureView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return status?.stordPictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(JYPictureCellReuseIdentifier, forIndexPath: indexPath) as! PictureViewCell
        
        if let imageURL = status?.stordPictureURLs![indexPath.row] {
            
            cell.imageURL = imageURL
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(JYShowWeiboPictrue, object: nil, userInfo: [JYShowWeiboPictrueIndex: indexPath, JYShowWeiboPictrueURLs: (status?.stordLagrePictureURLs!)!])
    }
}


private class PictureViewCell: UICollectionViewCell {
    
    private lazy var iconView = UIImageView()
    
    private lazy var girImageView: UIImageView = {
    
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "timeline_icon_like")
        
        imageView.hidden = true
        
        return imageView
    
    } ()
    
    var imageURL: NSURL? {
        
        didSet {
            
            if let imageURL = imageURL {
                
                let lastString = imageURL.lastPathComponent!
                
                let gifString = lastString.substringFromIndex(lastString.rangeOfString(".")!.endIndex)
                
                if "gif" == gifString {
                    
                    girImageView.hidden = false
                
                }
                
                
                
                iconView.contentMode = .ScaleAspectFit
                
                iconView.sd_setImageWithURL(imageURL)
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIs()
        
    }
    
    func setupUIs() {
        
        contentView.addSubview(iconView)
        
        contentView.addSubview(girImageView)
        
        iconView.xmg_Fill(contentView)
        
        girImageView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init?(coder aDecoder: NSCoder)没有实现")
    }
}