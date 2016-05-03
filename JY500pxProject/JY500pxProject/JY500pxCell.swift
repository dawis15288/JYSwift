//
//  JY500pxCell.swift
//  JY500pxProject
//
//  Created by atom on 16/4/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

class JY500pxCell: UICollectionViewCell {
    
    var request: Alamofire.Request?
    
    var photoInfo: PhotoInfo? {
        
        didSet {
            
            if let imageURL = photoInfo?.url {
                
                self.photoimageView.image = nil
                
                self.request?.cancel()
                
                self.request = Alamofire.request(.GET, imageURL).responseImage({ (response) in
                    
                    guard let image = response.result.value where response.result.error == nil else { return }
                    
                    self.photoimageView.image = image
                })
                
                /*JY500psNetTool.loadImage(imageURL) { (photo, error) in
                    
                    if photo != nil && error == nil {
                        
                        self.photoimageView.image = UIImage(data: photo!)
                    }
                }*/
            
            } else {
                
                print("url没有成功赋值！")
            
            }
            
            
        
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIS()
    }
    
    private func setupUIS() {
    
        self.contentView.addSubview(photoimageView)
        
        photoimageView.xmg_Fill(self.contentView)
    
    }
    
    private lazy var photoimageView: UIImageView = {
    
        let image = UIImageView()
        
        return image
    
    }()
    
    private lazy var photoTitle: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(13)
        
        return label
    
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
