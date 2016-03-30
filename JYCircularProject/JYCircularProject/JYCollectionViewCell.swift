//
//  JYCollectionViewCell.swift
//  JYCircularProject
//
//  Created by atom on 16/2/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String = "" {
        
        didSet {
            
            imageView.image = UIImage(named: imageName)
        
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        contentView.layer.cornerRadius = 5
        
        contentView.layer.borderColor = UIColor.blackColor().CGColor
        
        contentView.layer.borderWidth = 1
        
        contentView.layer.shouldRasterize = true
        
        contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        contentView.clipsToBounds = true
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.contentMode = .ScaleAspectFill
    }

}
