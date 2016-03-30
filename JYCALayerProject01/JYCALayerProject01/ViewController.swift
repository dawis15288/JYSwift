//
//  ViewController.swift
//  JYCALayerProject01
//
//  Created by atom on 16/2/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadViews: UIView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var userPassword: UILabel!
    @IBOutlet weak var login: UIButton!
    let antherOvalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    let ipadView = UIImageView(frame: CGRect(x: 200, y: 100, width: 200, height: 151.5))
    
    let iphoneView = UIImageView(frame: CGRect(x: 200, y: 400, width: 200, height: 151.5))
    
    @IBAction func login(sender: AnyObject) {
        
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: .AllowUserInteraction, animations: { () -> Void in
            
            print(self.login.bounds.size.width)
            
                self.login.bounds.size.width += 25
            
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [.AllowUserInteraction, .Autoreverse], animations: { () -> Void in
            
                self.login.center.y += 10
            
            }, completion: nil)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //beginSimpleAnimation()
        
        beginComplesAnimation()
        
        self.userName.center.x -= self.view.bounds.width
        
        self.userPassword.center.x -= self.view.bounds.width
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            
            self.userName.center.x += self.view.bounds.width
        
        })
        
        /*
        .CurveLinear ：该属性既不会使动画加速也不会使动画减速，只是做以线性运动。
        .CurveEaseIn：该属性使动画在开始时加速运行。
        .CurveEaseOut：该属性使动画在结束时减速运行。
        .CurveEaseInOut：该属性结合了上述两种情况，使动画在开始时加速，在结束时减速。
        
        */
        
        UIView.animateWithDuration(2.0, delay: 0.3, options: [.Repeat, .CurveEaseOut], animations: { () -> Void in
            
            //bounds：改变视图内容的位置和尺寸大小的属性。
            
            //frame：改变视图的位置和尺寸大小的属性。
            //center：改变视图位置的属性。
            
            
            self.userPassword.center.x += self.view.bounds.width
            
            }, completion: nil)
        
        let rotat = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.sun.transform = rotat
        
        })
        
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: .Repeat, animations: { () -> Void in
            
            self.sun.transform = scale
            
            
        }, completion: nil)
        
        self.login.center.y += 30
        
        self.login.alpha = 0
        
        /*
        usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
        initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
        
        */
        
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .AllowUserInteraction, animations: { () -> Void in
            
                self.login.center.y -= 30
            
                self.login.alpha = 1
            
            }, completion: nil)
        
        UIView.transitionWithView(self.view, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromBottom], animations: { [ unowned self ] () -> Void in
            
            print("UIView.transitionWithView")
            
           self.view.addSubview(self.ipadView)
            
            self.view.addSubview(self.iphoneView)
            
            }, completion: nil)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        antherOvalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        
        antherOvalShapeLayer.fillColor = UIColor.clearColor().CGColor
        
        antherOvalShapeLayer.lineWidth = 7
        
        let antherOvalRadius = loadViews.frame.size.height / 2 * 0.8
        
        antherOvalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: loadViews.frame.width / 4, y: loadViews.frame.size.height / 2 - antherOvalRadius, width: antherOvalRadius, height: antherOvalRadius)).CGPath
        
        antherOvalShapeLayer.lineCap = kCALineCapRound
        
        antherOvalShapeLayer.strokeEnd = 0.4
        
        loadViews.layer.addSublayer(antherOvalShapeLayer)
        
        ipadView.image = UIImage(named: "monitors")
        
        iphoneView.image = UIImage(named: "logo")
        
    }
    
    func beginSimpleAnimation() {
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        
        rotate.duration = 2
        
        rotate.fromValue = 2 * M_PI
        
        rotate.toValue = 0
        
        rotate.repeatCount = HUGE
        
        loadViews.layer.addAnimation(rotate, forKey: nil)
        
        //antherOvalShapeLayer.addAnimation(rotate, forKey: nil)
    
    }
    
    func beginComplesAnimation() {
        
        let strokeStartAnimate = CABasicAnimation(keyPath: "strokeStart")
        
        strokeStartAnimate.fromValue = -0.5
        
        strokeStartAnimate.toValue = 1
        
        let strokeEndAnimate = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeStartAnimate.fromValue = 0.0
        
        strokeStartAnimate.toValue = 1
        
        let strokeAnimateGroup = CAAnimationGroup()
        
        strokeAnimateGroup.duration = 1.5
        
        strokeAnimateGroup.repeatCount = HUGE
        
        strokeAnimateGroup.animations = [strokeStartAnimate, strokeEndAnimate]
        
        antherOvalShapeLayer.addAnimation(strokeAnimateGroup, forKey: nil)
        
        //loadViews.layer.addAnimation(strokeAnimateGroup, forKey: nil)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

