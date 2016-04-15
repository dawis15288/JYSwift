//
//  EmoticonPictrueFlowLayout.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class EmoticonPictrueFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
        itemSize = CGSize(width: 80, height: 80)
        
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }

}
