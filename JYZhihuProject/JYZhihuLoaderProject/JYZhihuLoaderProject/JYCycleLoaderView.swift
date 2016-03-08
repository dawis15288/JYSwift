//
//  JYCycleLoaderView.swift
//  JYZhihuLoaderProject
//
//  Created by atom on 16/2/26.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCycleLoaderView: UIView {

    private let cycleLayer: CAShapeLayer = CAShapeLayer()
    
    private var isAnimation: Bool = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        print("super.init(frame: frame)")
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        print("super.init(coder: aDecoder)")
        
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        print("super.awakeFromNib()")
        
        setupUI()
        
        
    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        print("super.didMoveToWindow()")
        
        updateUI()
        
    }

}

extension JYCycleLoaderView {
    
    private func setupUI() {
        
        cycleLayer.lineCap = "round"
        
        cycleLayer.lineJoin = "round"
        
        cycleLayer.lineWidth = 7
        
        cycleLayer.fillColor = UIColor.clearColor().CGColor
        
        cycleLayer.strokeColor = UIColor.redColor().CGColor
        
        cycleLayer.strokeEnd = 0
        
        layer.addSublayer(cycleLayer)
    
    }
    
    private func updateUI() {
        
        cycleLayer.frame = bounds
        
        cycleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    
    }

}

extension JYCycleLoaderView {
    
    func startAnimation() {
        
        guard !isAnimation else {
            
            return
        
        }
        
        isAnimation = true
        
        self.alpha = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.fromValue = -1
        
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.fromValue = 0
        
        strokeEndAnimation.toValue = 1.0
        
        
        let animationGroup = CAAnimationGroup()
        
        animationGroup.duration = 1.2
        
        animationGroup.repeatCount = HUGE
        
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        cycleLayer.addAnimation(animationGroup, forKey: "animationGroup")
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotateAnimation.fromValue = 0
        
        rotateAnimation.toValue = M_PI * 2
        
        rotateAnimation.repeatCount = HUGE
        
        rotateAnimation.duration = 1.2
        
        cycleLayer.addAnimation(rotateAnimation, forKey: "rotateAnimation")
    
    }
    
    func stopAnimation() {
    
        guard isAnimation else { return }
        
        UIView.animateWithDuration(0.2, animations: { [ unowned self ] () -> Void in
            
            self.alpha = 0
            
            }, completion: { [ unowned self ] (finish) -> Void in
                
                self.cycleLayer.removeAllAnimations()
                
                self.isAnimation = false
        
        })
    }

}
