//
//  PopoverPresentationControllr.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/4.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PopoverPresentationControllr: UIPresentationController {
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    
    override func containerViewWillLayoutSubviews() {
        
        containerView?.insertSubview(coverView, atIndex: 0)
        
        coverView.frame = (containerView?.frame)!
        
        presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 260)
    }
    
    lazy var coverView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        
        let tap = UITapGestureRecognizer(target: self, action: "close")
        
        view.addGestureRecognizer(tap)
        
        return view
    
    }()
    
    func close() {
        
        print("presentedViewController.dismissViewControllerAnimated(true, completion: nil)")
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    
    }

}
