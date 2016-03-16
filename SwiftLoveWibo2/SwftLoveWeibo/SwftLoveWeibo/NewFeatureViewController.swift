//
//  NewFeatureViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit



private let jyreuseIdentifier = "NewFeatureCell"

class NewFeatureViewController: UICollectionViewController {
    
     
    
    private let layout = JYFlowLayout()
    
    init() {
    
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(NewfatureCll.self, forCellWithReuseIdentifier: jyreuseIdentifier)

       
    }
    
}




