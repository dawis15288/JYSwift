//
//  JYPhotoLayout.swift
//  JY500pxProject
//
//  Created by atom on 16/5/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYPhotoLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
        /*itemSize = (collectionView?.bounds.size)!
        
        minimumInteritemSpacing = 0
        
        minimumLineSpacing = 0
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        
        collectionView?.bounces = false
        
        collectionView?.showsHorizontalScrollIndicator = false*/
        
        let width = ((collectionView?.bounds.size.width)! - 2) / 3
        
        let size = CGSize(width: width, height: width)
        
        
        itemSize = size
        
        minimumInteritemSpacing = 1.0
        
        minimumLineSpacing = 1.0
        
        footerReferenceSize = CGSize(width: (collectionView?.bounds.size.width)!, height: 100.0)
        
        /*scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        
        collectionView?.bounces = true
        
        collectionView?.showsHorizontalScrollIndicator = false*/
        
    }

}
