//
//  JYMainViewController.swift
//  JYPathLayerProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let finalSize = CGSize(width: CGRectGetWidth(view.frame), height: CGRectGetHeight(view.frame))
        
        let layerheight = finalSize.height * 0.2
        
        let layer = CAShapeLayer()
        
        let bezier = UIBezierPath()
        
        bezier.moveToPoint(CGPoint(x: 0, y: finalSize.height - layerheight))
        
        bezier.addLineToPoint(CGPoint(x: 0, y: finalSize.height - 1))
        
        bezier.addLineToPoint(CGPoint(x: finalSize.width, y: finalSize.height - 1))
        
        bezier.addLineToPoint(CGPoint(x: finalSize.width, y: finalSize.height - layerheight))
        
        bezier.addQuadCurveToPoint(CGPoint(x: 0, y: finalSize.height - layerheight), controlPoint: CGPoint(x: finalSize.width / 2, y: (finalSize.height - layerheight) - 40))
        
        layer.path = bezier.CGPath
        
        layer.fillColor = UIColor.clearColor().CGColor
        
        layer.strokeColor = UIColor.orangeColor().CGColor
        
        view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
