//
//  HomeRefreshControl.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class HomeRefreshControl: UIRefreshControl {
    
    override init() {
        
        super.init()
        
        setupUI()
    }
    
    override func endRefreshing() {
        
        super.endRefreshing()
        
        refreshView.stopLoadingViewAnimation()
        
        loadingAnimationFlag = false
    }
    
    private func setupUI() {
    
        addSubview(refreshView)
        
        refreshView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: CGSize(width: 170, height: 60))
        
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    var rotainArrowFlag = false
    
    var loadingAnimationFlag = false
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y >= 0 {
 
            return
        
        }
        
        if refreshing && !loadingAnimationFlag {
            
            loadingAnimationFlag = true
            
            refreshView.startLoadingViewAnimation()
            
            return
        
        }
        
        if frame.origin.y >= -50 && rotainArrowFlag {
            
            rotainArrowFlag = false
            
            refreshView.rotainArrowIcon(rotainArrowFlag)
        
            
        } else if frame.origin.y < -50 && !rotainArrowFlag {
          
            rotainArrowFlag = true
            
            refreshView.rotainArrowIcon(rotainArrowFlag)
            
        }
        
    }
    
    private lazy var refreshView: HomeRefreshView = HomeRefreshView.refreshView()
    
    deinit {
        
        removeObserver(self, forKeyPath: "frame", context: nil)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeRefreshView: UIView {
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var loadIcon: UIImageView!
    
    func rotainArrowIcon(flag: Bool) {
        
        var angle = M_PI
        
        angle += flag ? -0.01 : 0.01
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
        
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
        })
    
    }
    
    func startLoadingViewAnimation() {
        
        tipView.hidden = true
        
        loadIcon.hidden = false
        
        let animtaion = CABasicAnimation(keyPath: "transform.rotation")
        
        animtaion.toValue = 2 * M_PI
        
        animtaion.duration = 0.5
        
        animtaion.repeatCount = HUGE
        
        animtaion.removedOnCompletion = false
        
        loadIcon.layer.addAnimation(animtaion, forKey: nil)
    
    }
    
    func stopLoadingViewAnimation() {
        
        tipView.hidden = false
        
        loadIcon.hidden = true
        
        loadIcon.layer.removeAllAnimations()
    
    }
    
    class func refreshView() -> HomeRefreshView {
        
        return NSBundle.mainBundle().loadNibNamed("HomeRefreshView", owner: nil, options: nil).last as!HomeRefreshView
    
    }

}
