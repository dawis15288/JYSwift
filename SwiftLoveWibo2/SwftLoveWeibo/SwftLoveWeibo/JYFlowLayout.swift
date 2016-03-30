//
//  JYFlowLayout.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYFlowLayout: UICollectionViewFlowLayout {
    
     override func prepareLayout() {
        
        itemSize = (collectionView?.bounds.size)!
        
        minimumInteritemSpacing = 0
        
        minimumLineSpacing = 0
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
       collectionView?.pagingEnabled = true
        
        collectionView?.bounces = false
        
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
}
