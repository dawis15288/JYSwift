//
//  PctrueCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

protocol PctrueCellDelegate {
    
    func pctrueCellDelegate(cell: PctrueCell)
}

class PctrueCell: UICollectionViewCell {
    
    var pctrueCellDelegate: PctrueCellDelegate?
    
    lazy var iconView: UIImageView = {
        
        let imageView = UIImageView()
        
        return imageView
    
    }()
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    var imageURL: NSURL? {
        
        didSet {
            
            
            
            if let imageURL = imageURL {
                
                reset()
                
                iconView.contentMode = .ScaleAspectFit
                
                iconView.sd_setImageWithURL(imageURL, completed: { (image, _, _, _) -> Void in
                    
                    self.setImageViewpostion()
                
                })
            }
            
        }
        
    }
    
    private func displaySize(image: UIImage) -> CGSize {
        
        let cale = image.size.height / image.size.width
        
        let width = UIScreen.mainScreen().bounds.width
        
        let height = width * cale
        
        return CGSize(width: width, height: height)
    
    }
    
    private func setImageViewpostion() {
        
        if let image = self.iconView.image {
            
            let size = self.displaySize(image)
            
            if size.height < UIScreen.mainScreen().bounds.height {
                
                let y = (UIScreen.mainScreen().bounds.height - size.height) * 0.5
                
                self.iconView.frame = CGRect(origin: CGPointZero, size: size)
                
                self.scrollView.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
                
            } else {
                
                self.iconView.frame = CGRect(origin: CGPointZero, size: size)
                
                self.scrollView.contentSize = size
                
            }
        
        }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIs()
        
    }
    
    //cell重用导致显示照片错乱，在显示之前重置控件尺寸
    
    private func reset() {
    
        scrollView.contentInset = UIEdgeInsetsZero
        
        scrollView.contentSize = CGSizeZero
        
        scrollView.contentOffset = CGPointZero
        
        iconView.transform = CGAffineTransformIdentity
    }
    
    func setupUIs() {
        
        //contentView.addSubview(iconView)
        
        contentView.addSubview(scrollView)
        
        scrollView.addSubview(iconView)
        
        scrollView.frame = UIScreen.mainScreen().bounds
        
         scrollView.delegate = self
        
        scrollView.maximumZoomScale = 2.0
        
        scrollView.minimumZoomScale = 0.5
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        
        iconView.addGestureRecognizer(tap)
        
        //让图片可以和用户交互
        
        iconView.userInteractionEnabled = true
        
    }
    
    @objc private func close() {
        
        pctrueCellDelegate?.pctrueCellDelegate(self)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init?(coder aDecoder: NSCoder)没有实现")
    }

}

extension PctrueCell: UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return iconView
    }
    
    //缩放是通过transform实现的，只会影响frame而不会影响bounds
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
        var offsetX = (UIScreen.mainScreen().bounds.width - (view?.frame.width)!) * 0.5
        
        var offsetY = (UIScreen.mainScreen().bounds.height - (view?.frame.height)!) * 0.5
        
        offsetX = offsetX < 0 ? 0 : offsetX
        
        offsetY = offsetY < 0 ? 0 : offsetY
        
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: offsetY, right: offsetX)
        
    }

}
