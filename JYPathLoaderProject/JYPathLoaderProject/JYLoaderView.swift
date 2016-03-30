//
//  JYLoaderView.swift
//  JYPathLoaderProject
//
//  Created by atom on 16/2/26.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYLoaderView: UIView {

    let circlePathLayer = CAShapeLayer()
    
    let circleRadius = 20.0
    
    var progress: CGFloat {
        
        get {
            
            return circlePathLayer.strokeEnd
        
        }
        
        set {
            
            if newValue > 1 {
            
                circlePathLayer.strokeEnd = 1
            
            } else if newValue < 0 {
            
                circlePathLayer.strokeEnd = 0
                
            } else {
                
                circlePathLayer.strokeEnd = newValue
            
            }
            
            
        
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        circlePathLayer.frame = circleFrame()
        
        circlePathLayer.path = circlePath().CGPath
        
    }
    
    func configure() {
    
        circlePathLayer.frame = bounds
        
        circlePathLayer.lineWidth = 7
        
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        
        circlePathLayer.strokeColor = UIColor.redColor().CGColor
        
        layer.addSublayer(circlePathLayer)
        
        backgroundColor = UIColor.whiteColor()
        
        progress = 0.4
        
        self.layer.addSublayer(circlePathLayer)
    
    }
    
    func circleFrame() -> CGRect {
    
        var circleFrame = CGRect(x: 100, y: 200, width: 2 * circleRadius, height: 2 * circleRadius)
        
        //circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        
        //circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
    
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    func beginSimpleAnimation() {
        
        let pathAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        pathAnimation.fromValue = 0
        
        pathAnimation.toValue = 2 * M_PI
        
        pathAnimation.duration = 1.5
        
        pathAnimation.repeatCount = HUGE
        
        progress += 0.01
        
        //circlePathLayer.addAnimation(pathAnimation, forKey: "stromeWidth")
        
        self.layer.addAnimation(pathAnimation, forKey: "jyAnimation")
        
        /*let groupAniimation = CAAnimationGroup()
        
        groupAniimation.duration = 1
        
        groupAniimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        groupAniimation.animations = [pathAnimation]
        
        groupAniimation.delegate = self
        
        circlePathLayer.addAnimation(groupAniimation, forKey: "stromeWidth")*/
        
    
    }
    

}
