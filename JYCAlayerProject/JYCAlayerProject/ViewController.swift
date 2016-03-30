//
//  ViewController.swift
//  JYCAlayerProject
//
//  Created by atom on 16/2/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func viewWillAppear(animated: Bool) {
       // super.viewWillAppear(animated)
        
        beginAnimation()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //strokeColor：笔画颜色。
        //strokeStart：笔画开始位置。
        //strokeEnd：笔画结束位置。
        //fillColor：图形填充颜色。
        //lineWidth：笔画宽度，即笔画的粗细程度。
        //lineDashPattern：虚线模式。
        //path：图形的路径。
        //lineCap：笔画未闭合位置的形状。
        
        ovalShapeLayer.strokeColor = UIColor.orangeColor().CGColor
        
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        
        ovalShapeLayer.lineWidth = 5
        
        let ovalRadius = loadingView.frame.size.width / 2 * 0.8
        
        let ovalInRect = CGRect(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2 - ovalRadius, width: ovalRadius * 2, height: ovalRadius * 2)
        
        ovalShapeLayer.path = UIBezierPath(ovalInRect: ovalInRect).CGPath
        
        ovalShapeLayer.strokeEnd = 0.4
        
        ovalShapeLayer.lineCap = kCALineCapRound
        
        //ovalShapeLayer.lineCap = kCALineCapButt
        
        //ovalShapeLayer.lineCap = kCALineCapSquare
        
        //ovalShapeLayer.lineCap = kCALineJoinBevel
        
        //ovalShapeLayer.lineCap = kCALineJoinMiter
        
        //ovalShapeLayer.lineCap = kCALineJoinRound
        
        loadingView.layer.addSublayer(ovalShapeLayer)
        
    }
    
    func beginAnimation() {
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        
        rotate.duration = 1.0
        
        rotate.fromValue = 0
        
        rotate.toValue = 2 * M_PI
        
        rotate.repeatCount = HUGE
        
        loadingView.layer.addAnimation(rotate, forKey: nil)
        
        //ovalShapeLayer.addAnimation(rotate, forKey: nil)
    
    }
    
    func beginSimpleAnimation() {
        
        /*
        
        transform.rotation：旋转动画。
        transform.ratation.x：按x轴旋转动画。
        transform.ratation.y：按y轴旋转动画。
        transform.ratation.z：按z轴旋转动画。
        transform.scale：按比例放大缩小动画。
        transform.scale.x：在x轴按比例放大缩小动画。
        transform.scale.y：在y轴按比例放大缩小动画。
        transform.scale.z：在z轴按比例放大缩小动画。
        position：移动位置动画。
        opacity：透明度动画。
        
        */
        
        
        
        
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

