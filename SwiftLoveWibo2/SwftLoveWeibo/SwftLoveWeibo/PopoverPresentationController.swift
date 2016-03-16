//
//  PopoverPresentationController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/12.jj1



//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    var presentFrame = CGRectZero
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        //print(presentedViewController)
    }
    
    override func containerViewWillLayoutSubviews() {
        
        // 之前因为没有设置视图的约束，所以这里设置高和宽不起作用！
        
        if presentedViewController.title == "group" {
        
            if presentFrame == CGRectZero {
                
                presentedView()?.frame = CGRect(x: 120, y: 56, width: 180, height: 200)
            
            } else {
                
                presentedView()?.frame = presentFrame
            
            
            }
        } else if presentedViewController.title == "scan"  {
            
            
            
            if presentFrame == CGRectZero {
                
                presentedView()?.frame = CGRect(x: 328, y: 56, width: 80, height: 90)
                
            } else {
                
                presentedView()?.frame = presentFrame
                
                
            }
            
        }
        
        
        
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    private lazy var coverView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        
        view.frame = UIScreen.mainScreen().bounds
        
        let tap = UITapGestureRecognizer(target: self, action: "close")
        
        view.addGestureRecognizer(tap)
        
        return view
    
    }()
    
    func close() {
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    
    }

}
