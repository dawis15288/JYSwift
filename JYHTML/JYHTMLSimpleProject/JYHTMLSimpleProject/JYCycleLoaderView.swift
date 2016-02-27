//
//  JYCycleLoaderView.swift
//  JYHTMLSimpleProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCycleLoaderView : UIView {

    private let cycleLayr: CAShapeLayer = CAShapeLayer()
    
    private var isAnimation: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupUI()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func didMoveToWindow() {
        
        print("didMoveToWindow()")
        
        super.didMoveToWindow()
        
        updateUI()
    }

}

extension JYCycleLoaderView {
    
    private func setupUI() {
        
        cycleLayr.lineCap = "round"
        
        cycleLayr.lineJoin = "round"
        
        cycleLayr.lineWidth = 6
        
        cycleLayr.strokeColor = UIColor.blueColor().CGColor
        
        cycleLayr.fillColor = UIColor.clearColor().CGColor
        
        cycleLayr.strokeEnd = 0
        
        layer.addSublayer(cycleLayr)
    
    }
    
    private func updateUI() {
        
        cycleLayr.frame = bounds
        
        cycleLayr.path = UIBezierPath(ovalInRect: bounds).CGPath
    
    
    
    }

}

extension JYCycleLoaderView {
    
    
    
    func startAnimation() {
        
        guard !isAnimation else { return }
        
        print("startAnimation()")
        
        isAnimation = true
        
        self.alpha = 0.8
        
        cycleLayr.strokeEnd = 0.4
        
        /*let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.fromValue = -1
        
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.fromValue = 0
        
        strokeEndAnimation.toValue = 1.0

        let animationGroup = CAAnimationGroup()
        
        animationGroup.duration = 1.5
        
        animationGroup.repeatCount = HUGE
        
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        cycleLayr.addAnimation(animationGroup, forKey: "animationGroup")*/
        
        let rotateAnmiation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotateAnmiation.fromValue = 0
        
        rotateAnmiation.toValue = M_PI * 2
        
        rotateAnmiation.repeatCount = HUGE
        
        rotateAnmiation.duration = 1.5
        
        cycleLayr.addAnimation(rotateAnmiation, forKey: "rotateAnimation")
    
    }
    
    func stopAnimation() {
        
        guard isAnimation else { return }
        
        UIView.animateWithDuration(1.2, animations: { [unowned self ] () -> Void in
            
            self.alpha = 0
            
            
            }, completion: { [ unowned self] (finish) -> Void in
            
                self.cycleLayr.removeAllAnimations()
                
                self.isAnimation = false
            
            })
    
    }

}
