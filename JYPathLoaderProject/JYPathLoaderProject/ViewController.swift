//
//  ViewController.swift
//  JYPathLoaderProject
//
//  Created by atom on 16/2/26.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressIndicatorView = JYLoaderView(frame: CGRectZero)
    
    let cycleLayer = CAShapeLayer()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.]
        
        /*self.view.addSubview(progressIndicatorView)
        
        progressIndicatorView.frame = self.view.bounds
        
        print(progressIndicatorView.circleFrame())
        
        progressIndicatorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        progressIndicatorView.beginSimpleAnimation()*/
        
        cycleLayer.lineCap = kCALineCapRound
        
        cycleLayer.lineJoin = kCALineJoinRound
        
        cycleLayer.lineWidth = 7
        
        cycleLayer.fillColor = UIColor.clearColor().CGColor
        
        cycleLayer.strokeColor = UIColor.orangeColor().CGColor
        
        cycleLayer.strokeEnd = 0.4
        
        cycleLayer.path = UIBezierPath(ovalInRect: CGRect(x: 100.0, y: 200.0, width: 40.0, height: 40.0)).CGPath
        
        self.view.layer.addSublayer(cycleLayer)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.fromValue = -1
        
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokEnd")
        
        strokeEndAnimation.fromValue = 0
        
        strokeEndAnimation.toValue = 1.0
        
        let animateionGroup = CAAnimationGroup()
        
        animateionGroup.duration = 1.5
        
        animateionGroup.repeatCount = HUGE
        
        animateionGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        cycleLayer.addAnimation(animateionGroup, forKey: "animateionGroup")
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotateAnimation.fromValue = 0
        
        rotateAnimation.toValue = 2 * M_PI
        
        rotateAnimation.repeatCount = HUGE
        
        rotateAnimation.duration = 1.5
        
        cycleLayer.addAnimation(rotateAnimation, forKey: "rotateAnimation")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

