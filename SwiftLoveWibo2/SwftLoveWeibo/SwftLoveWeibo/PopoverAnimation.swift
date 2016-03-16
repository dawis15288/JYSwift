//
//  PopoverAnimation.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PopoverAnimation: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    
    var presentFrame = CGRectZero
    
    // MARK: popoverde 代
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        print(presented.title)
        let pc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
        pc.presentFrame = presentFrame
        
        return pc
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        
        
        NSNotificationCenter.defaultCenter().postNotificationName(JYPopoverAnimatorWillShowNotification, object: self)
        
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        
        NSNotificationCenter.defaultCenter().postNotificationName(JYPopoverAnimatorWillDismissNotification, object: self)
        
        return self
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.6
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            
            print("展开视图")
            
            let tVew = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            
            
            //把要呈现的视图添加到容器中，才能显示！
            print(tVew)
            
            tVew.transform = CGAffineTransformMakeScale(1.0, 0.0)
            
            transitionContext.containerView()?.addSubview(tVew)
            
            tVew.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                
                tVew.transform = CGAffineTransformIdentity
                
                }, completion: { (_) -> Void in
                    
                    transitionContext.completeTransition(true)
                    
            })
            
        } else {
            
            print("关闭视图")
            
            let formView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                
                //由于CGFloat是不准确的，所以0.0是没动画，需要设置一个很小的数
                
                formView.transform = CGAffineTransformMakeScale(1.0, 0.000001)
                
                }, completion: { (_) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
            
        }
        
        
        
    }
}
