//
//  MenuTransitionManager.swift
//  JYSlideMenu
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate {
    
    func dismiss()

}

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration = 0.5
    
    var isPresenting = false
    
    var delegate: MenuTransitionManagerDelegate?
    
    var snapshot: UIView? {
        
        didSet {
            
            if let _delegate = delegate {
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: "dismiss")
                
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            
            }
            
        
        }
    
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return duration
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let frommView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let container = transitionContext.containerView()
        
        let moveDown = CGAffineTransformMakeTranslation(0, (container?.frame.height)! - 400)
        
        let moveup = CGAffineTransformMakeTranslation(0, -50)
        
        if isPresenting {
            
            toView.transform = moveup
            
            snapshot = frommView.snapshotViewAfterScreenUpdates(true)
            
            container?.addSubview(toView)
            
            container?.addSubview(snapshot!)
        
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseOut, animations: {
            
            if self.isPresenting {
                
                self.snapshot?.transform = moveDown
                
                toView.transform = CGAffineTransformIdentity
            
            } else {
            
                self.snapshot?.transform = CGAffineTransformIdentity
                
                frommView.transform = moveup
                
            }
            
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                
                if !self.isPresenting {
                    
                    self.snapshot?.removeFromSuperview()
                
                }
        
        })
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        
        return self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        
        return self
    }

}
