//
//  new.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

private let jyreuseIdentifier = "NewFeatureCell"

private let imageCount = 4

extension NewFeatureViewController {
    
   
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(jyreuseIdentifier, forIndexPath: indexPath) as! NewfatureCll
        
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let path = collectionView.indexPathsForVisibleItems().last!
        
        if path.item == (imageCount - 1) {
            
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewfatureCll
            
            cell.startAnimation()
            
        }
    }
    
    
}