//
//  NewFeatureViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewFeatureCell"

class NewFeatureViewController: UICollectionViewController {
    
    private let imageCount = 4
    
    private let layout = JYFlowLayout()
    
    init() {
    
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(NewfatureCll.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewfatureCll
        
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
    
private class JYFlowLayout: UICollectionViewFlowLayout {
        
        private override func prepareLayout() {
            
            itemSize = (collectionView?.bounds.size)!
            
            minimumInteritemSpacing = 0
            
            minimumLineSpacing = 0
            
            scrollDirection = UICollectionViewScrollDirection.Horizontal
            
            collectionView?.pagingEnabled = true
            
            collectionView?.bounces = false
            
            collectionView?.showsHorizontalScrollIndicator = false
        }
        
    }

}


