//
//  WelcomeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SDWebImage

class WelcomeViewController: UIViewController {
    
    
    private var iconBottomCons: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /*
        
        */
        
        setupUI()
        
        if  let account = UserAccount.loadAccount() {
            
            account.loadUserInfo( { (account, error) -> () in
                
                if account != nil && error == nil {
                    
                    if let imageURLString = account!.avatar_large {
                        
                        if let imageURL = NSURL(string: imageURLString) {
                            
                            let request = NSURLRequest(URL: imageURL)
                            
                            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                            
                            let task = session.dataTaskWithRequest(request, completionHandler: { [ unowned self ] (data, response, error) -> Void in
                                
                                if response != nil {
                                    
                                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                                        
                                        
                                        
                                        if let data = data {
                                            
                                            dispatch_async(dispatch_get_main_queue(), {  () -> Void in
                                                
                                                    self.iconView.image = UIImage(data: data)
                                                
                                                })
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            })
                            
                            task.resume()
                            
                        }
                        
                    }
                
                }
            
            })
        
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        iconBottomCons!.constant = -UIScreen.mainScreen().bounds.height - iconBottomCons!.constant
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 100, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            self.iconView.layoutIfNeeded()
            
            }, completion: { (finish) -> Void in
                
                UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    
                    self.message.alpha = 1.0
                    
                    self.message.textColor = UIColor.orangeColor()
                    
                    }, completion: { (finish) -> Void in
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(JYRootViewControllerSwitchNotification, object: true)
                })
                
        })
    }
    
    private lazy var bgImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        iv.layer.cornerRadius = 50
        
        iv.layer.masksToBounds = true
        
        return iv
        
    }()
    
    private lazy var message: UILabel = {
        
        let lable = UILabel()
        
        lable.text = "欢迎回来"
        
        lable.sizeToFit()
        
        lable.alpha = 0.0
        
        return lable
        
    }()
    
    private func setupUI() {
        
        view.addSubview(bgImageView)
        
        view.addSubview(iconView)
        
        view.addSubview(message)
        
        bgImageView.JY_Fill(view)
        
        let cons = iconView.JY_AlignInner(type: JY_AlignType.BottomCenter, referView: view, size: CGSize(width: 100, height: 100), offset: CGPoint(x: 0, y: -200))
        
        iconBottomCons = iconView.jy_Constraint(cons, attribute: .Bottom)!
        
        self.loadViewIfNeeded()
        
        message.JY_AlignInner(type: JY_AlignType.BottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 40))
        
        
        
    }

}
