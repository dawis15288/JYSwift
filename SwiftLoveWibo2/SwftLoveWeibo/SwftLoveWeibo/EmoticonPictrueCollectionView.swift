//
//  EmoticonPictrueCollectionView.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

let EmoticonPictrueReuseIdentifier = "EmoticonPictrueReuseIdentifier"


class EmoticonPictrueCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor.darkGrayColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}



@objc protocol EmoticoPictrueCellDelegate: NSObjectProtocol {

    optional func EmoticonPictrueDidSelector(cell: EmoticoPictrueCell)
    
    optional func EmoticonPictrueDidRemove(cell: EmoticoPictrueCell)
}

class EmoticoPictrueCell: UICollectionViewCell {
    
    var delegate: EmoticoPictrueCellDelegate?
    
    var image: UIImage? {
        
        didSet {
                 
            //removePictrue
            
            if image != nil {
                
                addButton.setImage(image!, forState: UIControlState.Normal)
            
            } else {
                
                addButton.setImage(UIImage(named: "compose_pic_big_add"), forState: UIControlState.Normal)
            
            }
            
            remveButton.hidden = (image == nil)
        
        }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIs()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIs() {
        
        contentView.addSubview(addButton)
        
        contentView.addSubview(remveButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        remveButton.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton": addButton])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton": addButton])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[remveButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["remveButton": remveButton])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[remveButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["remveButton": remveButton])
        
        contentView.addConstraints(cons)
        
    }
    
    
    private lazy var addButton: UIButton = {
        
        let addButton = UIButton()
        
        addButton.imageView?.contentMode = UIViewContentMode.ScaleToFill
        
        addButton.addTarget(self, action: #selector(addPictrue), forControlEvents: UIControlEvents.TouchUpInside)
        
        return addButton
    
    }()
    
    @objc private func addPictrue() {
    
        if image == nil {
        
            delegate?.EmoticonPictrueDidSelector!(self)
            
        }
    }
    
    private lazy var remveButton: UIButton = {
        
        let removeButton = UIButton()
        
        removeButton.setImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Normal)
        
        removeButton.hidden = true
        
        removeButton.addTarget(self, action: #selector(removePictrue), forControlEvents: UIControlEvents.TouchUpInside)
        
        return removeButton
    
    }()
    
    private lazy var imageVew: UIImageView = UIImageView()
    
    @objc private func removePictrue() {
        
        delegate?.EmoticonPictrueDidRemove!(self)
        
    }
}

