//
//  JYCollectionViewLayout.swift
//  JYCircularProject
//
//  Created by atom on 16/2/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    var angle: CGFloat = 0 {
        
        didSet {
            
            zIndex = Int(angle * 1000000)
            
            transform = CGAffineTransformMakeRotation(angle)
        
        }
    
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copiedAttributes: JYCollectionViewLayoutAttributes = super.copyWithZone(zone) as! JYCollectionViewLayoutAttributes
        
        copiedAttributes.anchorPoint = self.anchorPoint
        
        copiedAttributes.angle = self.angle
        
        return copiedAttributes
    }
    
    
}

class JYCollectionViewLayout: UICollectionViewLayout {
    
    let itemSize = CGSize(width: 133, height: 173)
    
    var attributesList = [JYCollectionViewLayoutAttributes]()
    
    var radius: CGFloat = 500 {
        
        didSet {
            
            invalidateLayout()
        
        }
    
    }
    
    var anglePerItem: CGFloat {
        
        return atan(itemSize.width / radius)
    
    }
    
    override func prepareLayout() {
        
        let centenX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        
        attributesList = (0 ..< collectionView!.numberOfItemsInSection(0)).map { (i) -> JYCollectionViewLayoutAttributes in
            
            let attributes = JYCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            attributes.size = self.itemSize
            
            attributes.center = CGPoint(x: centenX, y: CGRectGetMaxY(self.collectionView!.bounds))
            
            attributes.angle = self.anglePerItem * CGFloat(i)
            
            return attributes
        
        }
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributesList
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        return attributesList[indexPath.row]
        
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        
        return JYCollectionViewLayoutAttributes.self
    
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width, height: CGRectGetHeight(collectionView!.bounds))
    }

}
