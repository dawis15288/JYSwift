//
//  LaunchImageViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import PKRevealController

class LaunchImageViewController: UIViewController {
    
    @IBOutlet weak var launchImageView: UIImageView!
    @IBOutlet var launchView: UIView!
    private let TIME_DURATION = 4.0
    
    private let FROM_TIME_DURATION = 1.66
    
    private let ALPHA: CGFloat = 0.0
    
    private let X_SCALE: CGFloat = 1.15
    
    private let Y_SCALE: CGFloat = 1.55
    
    private var myImage: UIImage!
    
    private var sourcLabel: UILabel!
    
    var jumpToviewController: UIViewController!
    
    private let fromImageView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    
    private let toImageView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    
    private let maskImagView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    
    private var logoImageView: UIImageView?
    
    static var jumpTo: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.respondsToSelector("setNeedsStatusBarAppearanceUpdate") {
            
            self.prefersStatusBarHidden()
            
            self.setNeedsStatusBarAppearanceUpdate()
        
        }
        
        let width = UIScreen.mainScreen().bounds.width
        
        let height = width > 400 ? width * 570 / 1535 : 185
        
        logoImageView = UIImageView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - height, width: width, height: height))
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.fromImageView.image = UIImage(named: "FakeLaunchImage")
        self.view.addSubview(self.fromImageView)
        
        
        self.maskImagView.image = UIImage(named: "MaskImage")
        self.view.insertSubview(self.maskImagView, belowSubview: self.fromImageView)
        
        self.toImageView.image = self.myImage
        self.view.insertSubview(self.toImageView, belowSubview: self.maskImagView)
        
        self.logoImageView!.image = UIImage(named: "Splash_Logo_Plus")
        self.view.insertSubview(self.logoImageView!, aboveSubview: self.toImageView)
        
        self.view.addSubview(self.sourcLabel)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.beginAnimations(nil, context: nil)
        
        UIView.setAnimationDuration(FROM_TIME_DURATION)
        
        self.fromImageView.alpha = ALPHA
        UIView.commitAnimations()
        
        
        UIView.beginAnimations(nil, context: nil)
        
        UIView.setAnimationDuration(TIME_DURATION)
        
        let transform = CGAffineTransformMakeScale(X_SCALE, Y_SCALE)
        
        self.toImageView.transform = transform
        
        UIView.commitAnimations()
        
        NSTimer.scheduledTimerWithTimeInterval(TIME_DURATION, target: self, selector: "presentNextViewController:", userInfo: self.jumpToviewController
            , repeats: false)
        
    }
    
    func presentNextViewController(timer: NSTimer) {
        
        let viewController: UIViewController = timer.userInfo as! UIViewController
        
        self.presentViewController(jumpToviewController, animated: true, completion: { () -> Void in
            
            if LaunchImageViewController.jumpTo != nil {
                
                let rootNavgationViewController = viewController as! UINavigationController
                
               let pkRevealController = rootNavgationViewController.viewControllers.first as? PKRevealController
                
                let rootViewControllr =  pkRevealController?.frontViewController
                
                rootViewControllr?.performSegueWithIdentifier("pushSegue", sender: LaunchImageViewController.jumpTo)
                
                LaunchImageViewController.jumpTo = nil
            
            }
        
        })
    
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    class func addTransitionToViewControllr(viewController: UIViewController, modalTransitionStyle theStyle: UIModalTransitionStyle, withImagData imagData: UIImage, withSourceNam name: String) -> UIViewController? {
        
        let instance = LaunchImageViewController()
        
        instance.initWithTargetView(viewController, modalTranstionStyle: theStyle, withImageData: imagData, withSourceName: name)
        
        return instance
    
    }
    
    func initWithTargetView(targetView: UIViewController, modalTranstionStyle theStyle: UIModalTransitionStyle, withImageData imageData: UIImage, withSourceName name: String) {
        
        targetView.modalTransitionStyle = theStyle
        
        self.jumpToviewController = targetView
        
        self.myImage = imageData
        
        let rect = jumpToviewController.view.frame
        
        self.sourcLabel = UILabel(frame: CGRect(x: (rect.size.width - 200) / 2, y: (rect.size.height - 30 ), width: 200, height: 30))
        
        self.sourcLabel.text = name
        
        self.sourcLabel.textColor = UIColor.grayColor()
        
        self.sourcLabel.font = UIFont.systemFontOfSize(15)
        
        self.sourcLabel.textAlignment = NSTextAlignment.Center
        
        self.sourcLabel.textColor = UIColor.whiteColor()
        
        self.sourcLabel.backgroundColor = UIColor.clearColor()
        
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
