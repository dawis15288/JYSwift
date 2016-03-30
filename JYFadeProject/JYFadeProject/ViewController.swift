//
//  ViewController.swift
//  JYFadeProject
//
//  Created by atom on 16/2/5.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fadeView: UIView!
    
    //var animationHappening = false
    
    var fadeViewHidden = false
    
    let kCircleViewSize: CGFloat = 90.0
    
    var circleView: UIView!
    
    var animationHappening = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCircleView()
        
        setupSwipeAcgtions()
        
        setupTapAction()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        if (self.circleView.superview == nil) {
            
            self.view.addSubview(self.circleView)
        
        }
        
        self.circleView.center = self.view.center
    }
    
    func setupCircleView() {
        
        let frame = CGRectMake(0, 0, kCircleViewSize, kCircleViewSize)
        
        self.circleView = UIView(frame: frame)
        
        self.circleView.layer.cornerRadius = kCircleViewSize / 2.0
        
        self.circleView.backgroundColor = UIColor.purpleColor()
    
    }
    
    func setupSwipeAcgtions() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeOnMainView:")
        
        swipeDown.direction = .Down
        
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeOnMainView:")
        
        swipeUp.direction = .Up
        
        self.view.addGestureRecognizer(swipeUp)
    
    }
    
    func swipeOnMainView(swipe: UISwipeGestureRecognizer) {
        
        if self.animationHappening {
            
            return
        
        }
        
        let frameBegin = self.circleView.frame
        
        var frameEnd: CGRect = frameBegin
        
        if swipe.direction == .Down {
            
            frameEnd = CGRectMake(frameBegin.origin.x, self.view.frame.size.height - kCircleViewSize, kCircleViewSize, kCircleViewSize)
        
        } else {
            
            frameEnd = CGRectMake(frameBegin.origin.x, 40, kCircleViewSize, kCircleViewSize)
        
        }
        
        self.animationHappening = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.circleView.frame = frameEnd
        
            }) { (finishe) -> Void in
                
                self.animationHappening = false
        
        }
    
    }
    
    func setupTapAction() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: "tappedOnMainView:")
        
        singleTap.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(singleTap)
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "tappedOnMainView:")
        
        doubleTap.numberOfTapsRequired = 2
        
        self.view.addGestureRecognizer(doubleTap)
        
        singleTap.requireGestureRecognizerToFail(doubleTap)
    
    }
    
    func tappedOnMainView(tap: UITapGestureRecognizer) {
        
        if self.animationHappening
        {
            
            return
        
        }
        
        var transform = CGAffineTransformIdentity
        
        if tap.numberOfTapsRequired == 1 {
            
            transform = CGAffineTransformScale(self.circleView.transform, 1.3, 1.3)
            
        
        }
        
        self.animationHappening = true
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
        
            self.circleView.transform = transform
        
            }) { (finished) -> Void in
                
                self.animationHappening = false
        
        }
    
    }

    @IBAction func buttonFadeTapped(sender: AnyObject) {
        
        if animationHappening {
            
            return
        
        }
        
        self.animationHappening = true
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            
            if (self.fadeViewHidden) {
                
                self.fadeView.alpha = 0.6
                print("alpha ->> 1")
            
            } else {
                
                self.fadeView.alpha = 0.0
                print("alpha ->> 0")
            
            }
        
            }) { (finished) -> Void in
        
                self.animationHappening = false
                
                self.fadeViewHidden = !self.fadeViewHidden
        
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

