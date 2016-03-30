//
//  CardViewController.swift
//  JYProject37
//
//  Created by atom on 16/2/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import GameplayKit

class CardViewController: UIViewController {
    
    weak var delegate: ViewController!
    
    var front: UIImageView!
    
    var back: UIImageView!
    
    var isCorrect = false
    
    var isTap = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        view.bounds = CGRectMake(0, 0, 100, 140)
        
        front = UIImageView(image: UIImage(named: "cardBack"))
        
        back = UIImageView(image: UIImage(named: "cardBack"))
        
        view.addSubview(front)
        
        view.addSubview(back)
        
        front.hidden = true
        
        back.alpha = 0
        
        UIView.animateWithDuration(0.2) {
        
            self.back.alpha = 1
        }
        
        //let tap = UITapGestureRecognizer(target: self, action: "cardTapped:")
        
        let tap = UITapGestureRecognizer(target: self, action: "jyTapped")
        
        back.userInteractionEnabled = true
        
        back.addGestureRecognizer(tap)
        
        //print(back.gestureRecognizers)
        
        performSelector("wiggle", withObject: nil, afterDelay: 1)
    
    }
    
    func jyTapped() {
        
        print(isTap)
        
        isTap = true
        
        delegate.cardTapped(self)
    
    }
    
    func wasntTapped() {
    
        UIView.animateWithDuration(0.7) {
            
            self.view.transform = CGAffineTransformMakeScale(0.00001, 0.00001)
            
            self.view.alpha = 0
        
        }
    
    }
    
    func wasTapped() {
        
        UIView.transitionWithView(view, duration: 0.7, options: [.TransitionFlipFromRight], animations: { [unowned self] in
            
            self.back.hidden = true
            
            self.front.hidden = false
            
            }, completion: nil)
    
    }
    
    func wiggle() {
        
        print("wiggle")
        
        if GKRandomSource.sharedRandom().nextIntWithUpperBound(4) == 1 {
        
            UIView.animateWithDuration(0.2, delay: 0, options: .AllowUserInteraction, animations: {
                
                    self.back.transform = CGAffineTransformMakeScale(1.01, 1.01)
                
                }) { _ in
            
                    self.back.transform = CGAffineTransformIdentity
            
            }
            
            performSelector("wiggle", withObject: nil, afterDelay: 8)
        
        } else {
        
            performSelector("wiggle", withObject: nil, afterDelay: 2)
        
        }
    
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
