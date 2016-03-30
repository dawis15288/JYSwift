//
//  JYViewController.swift
//  JYCALayerProject01
//
//  Created by atom on 16/2/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYViewController: UIViewController {
    
    
    @IBOutlet weak var ipadContainer: UIView!
    
    @IBOutlet weak var webContainerVieww: UIView!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textContainerView: UIView!
    
    let ipadView = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        /*
        .TransitionFlipFromLeft
        .TransitionFlipFromRight
        .TransitionCurlUp
        .TransitionCurlDown
        .TransitionCrossDissolve
        .TransitionFlipFromTop
        .TransitionFlipFromBottom
        
        */
        
        delay(0, completionHandler: { () -> Void in
            
            UIView.transitionWithView(self.containerView, duration: 1.0, options: .TransitionFlipFromTop, animations: { [unowned self] () -> Void in
                
                self.containerView.addSubview(self.ipadView)
                
                }, completion: nil)
            
        })
        
        delay(1, completionHandler: { () -> Void in
            
            UIView.transitionWithView(self.ipadContainer, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromBottom], animations: { () -> Void in
                
                
                }, completion: nil)
        
        })
        
        
        delay(2, completionHandler: { () -> Void in
        
            UIView.transitionWithView(self.webContainerVieww, duration: 2.0, options: [.CurveEaseOut, .TransitionFlipFromLeft], animations: { () -> Void in}, completion: nil)
        
        })
        
        delay(3, completionHandler: { () -> Void in
        
            UIView.transitionWithView(self.textContainerView, duration: 2.5, options: [.CurveEaseOut, .TransitionFlipFromRight], animations: { () -> Void in}, completion: nil)
            
        })
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ipadView.image = UIImage(named: "logo")
        
    }
    
    func delay(seconds: Double,completionHandler: () -> Void) {
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds))
        
        dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
            
            completionHandler()
        
        })
    
    
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
