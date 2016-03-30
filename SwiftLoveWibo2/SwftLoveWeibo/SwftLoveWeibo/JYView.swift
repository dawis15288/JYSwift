//
//  JYView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYView: UIView {
    
    
    private lazy var EmojiCollectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())

    
    private lazy var EmojiToolBar: UIToolbar = {
        
        let toolBar = UIToolbar()
        
        toolBar.tintColor = UIColor.whiteColor()
        
        var items = [UIBarButtonItem]()
        
        var index = 0
        
        for title in ["最近", "默认", "Emoji", "浪小花"] {
            
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(itemClick))
            
            items.append(item)
            
            item.tag = index
            
            index += 1
            
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        
        }
        
        items.removeLast()
        
        toolBar.items = items
        
        return toolBar
    
    }()
    
    func itemClick() {
    
    
    }

}
