//
//  ViewController.swift
//  JYPathLayerProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let layer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        //layer.frame = CGRect(x: 110, y: 100, width: 150, height: 100)
        
        //矩形
        
        //let path = UIBezierPath(rect: CGRect(x: 110, y: 100, width: 150, height: 100)).CGPath
        
        //带圆角的矩形
        
        //let path = UIBezierPath(roundedRect: CGRect(x: 110, y: 100, width: 200, height: 100), cornerRadius:50).CGPath
        
        //圆形
        
       /* let radius: CGFloat = 60.0
        
        let startAngle: CGFloat = 0.0
        
        let endAngle = CGFloat(M_PI * 2)
        
        
        let path = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath*/
        
        let startPoint = CGPoint(x: 50, y: 300)
        
        let endPoint = CGPoint(x: 300, y: 300)
        
        let controlPoint = CGPoint(x: 170, y: 200)
        
        let controlPoint1 = CGPoint(x: 190, y: 400)
        
        
        let layer1 = CALayer()
        
        layer1.frame = CGRect(x: startPoint.x, y: startPoint.y , width: 5, height: 5)
        
        layer1.backgroundColor = UIColor.redColor().CGColor
        
        let layer2 = CALayer()
        
        layer2.frame = CGRect(x: endPoint.x, y: endPoint.y, width: 5, height: 5)
        
        layer2.backgroundColor = UIColor.redColor().CGColor
        
        let layer3 = CALayer()
        
        layer3.frame = CGRect(x: controlPoint.x, y: controlPoint.y, width: 5, height: 5)
        
        layer3.backgroundColor = UIColor.redColor().CGColor
        
        let layer4 = CALayer()
        
        layer4.frame = CGRect(x: controlPoint1.x, y: controlPoint1.y, width: 5, height: 5)
        
        layer4.backgroundColor = UIColor.redColor().CGColor
        
        let path = UIBezierPath()
        
        path.moveToPoint(startPoint)
        
        //path.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
        
        path.addCurveToPoint(endPoint, controlPoint1: controlPoint, controlPoint2: controlPoint1)
        
        layer.path = path.CGPath
        
        layer.fillColor = UIColor.clearColor().CGColor
        
        layer.strokeColor = UIColor.orangeColor().CGColor
        
        view.layer.addSublayer(layer)
        
        view.layer.addSublayer(layer1)
        
        view.layer.addSublayer(layer2)
        
        view.layer.addSublayer(layer3)
        
        view.layer.addSublayer(layer4)
        
        //animation1()
        //animation2()
        
        animation3()
        
        animation4()
        
    }
    
    private func animation1() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.fromValue = 0
        
        animation.toValue = 1
        
        animation.duration = 2
        
        layer.addAnimation(animation, forKey: "")
    
    }
    
    private func animation4() {
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        
        animation.fromValue = 1
        
        animation.toValue = 0
        
        animation.duration = 4
        
        layer.addAnimation(animation, forKey: "")
    
    }
    
    private func animation2() {
        
        layer.strokeStart = 0.5
        
        layer.strokeEnd = 0.5
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        
        animation.fromValue = 0.5
        
        animation.toValue = 0
        
        animation.duration = 2
        
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        
        animation2.fromValue = 0.5
        
        animation2.toValue = 1

        animation2.duration = 2
        
        layer.addAnimation(animation, forKey: "")
        
        layer.addAnimation(animation2, forKey: "")
    
    }
    
    private func animation3() {
        
        let animation = CABasicAnimation(keyPath: "lineWidth")
        
        animation.fromValue = 1
        
        animation.toValue = 10
        
        animation.duration = 2
        
        layer.addAnimation(animation, forKey: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

