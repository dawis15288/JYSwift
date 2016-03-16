//
//  StatusPictureView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/10.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusPictureView: UICollectionView {

    private lazy var iconView = UIImageView()
    
    var status: Status? {
        
        didSet {
            
            sizeToFit()
            
            reloadData()
        
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        
        return calculateImageSize()
    }
    
    private var pictureLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        
        super.init(frame: CGRectZero, collectionViewLayout: pictureLayout)
        
        registerClass(PictureViewCell.self, forCellWithReuseIdentifier: JYPictureCellReuseIdentifier)
        
        dataSource = self
        
        backgroundColor = UIColor.lightGrayColor()
        
        pictureLayout.minimumInteritemSpacing = 2
        
        pictureLayout.minimumLineSpacing = 2
        
        backgroundColor = UIColor.darkGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init?(coder aDecoder: NSCoder)没有实现")
    }
    
    // MARK: -处理微博中的图片
    
    func calculateImageSize() -> CGSize {
        
        if let count = status?.stordPictureURLs?.count {
        
            if count == 0 {
            
                return CGSizeZero
            
            }
        
            let width = 45
        
            let margin = 5
        
            pictureLayout.itemSize = CGSize(width: width, height: width)
        
            if count == 4 {
            
                let viewWidth = width * 2 + margin
            
                return CGSize(width: viewWidth, height: viewWidth)
            
            
            }
        
            let colCount = 3
        
            let rowCount = (count - 1) / 3 + 1
        
            let pictureWidth = colCount * width + (colCount - 1) * margin
        
            let pictureHeight = rowCount * width + (rowCount - 1 ) * margin
        
            return CGSize(width: pictureWidth, height: pictureHeight)
        }
        
        return CGSizeZero
    
    }
    
    //MARK: cell的实现
    private class PictureViewCell: UICollectionViewCell {
        
        private lazy var iconView = UIImageView()
        
        var imageURL: NSURL? {
            
            didSet {
                
                if let imageURL = imageURL {
                    
                    print("UICollectionViewCell\(imageURL)")
                    
                    //iconView.sd_setImageWithURL(imageURL)
                }
                
            }
            
        }
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
            
            setupUIs()
            
        }
        
        func setupUIs() {
            
            contentView.addSubview(iconView)
            
            iconView.JY_Fill(contentView)
        
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            fatalError("init?(coder aDecoder: NSCoder)没有实现")
        }
    
    }
}

extension StatusPictureView: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return status?.stordPictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCellWithReuseIdentifier(JYPictureCellReuseIdentifier, forIndexPath: indexPath) as! PictureViewCell
        
        //print("itemCell.imageURL = \(status?.stordPictureURLs![indexPath.row])")
        
        itemCell.imageURL = status?.stordPictureURLs![indexPath.row]
        
        if let imagURL = status?.stordPictureURLs![indexPath.row] {
            
            itemCell.iconView.sd_setImageWithURL(imagURL)
            
        }
        
        
        
        return itemCell
    }
}
