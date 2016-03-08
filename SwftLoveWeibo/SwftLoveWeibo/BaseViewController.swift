//
//  BaseViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/8.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    override func loadView() {
        
        super.loadView()
        
        //let visitorView = VisitorView()
        
        //view = visitorView
        
        setupUI()
        
        //view.backgroundColor = UIColor.clearColor()
       // navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "loginWeibo:")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    func  loginWeibo(sender: UIBarButtonItem) {
        
        let weiboAuthor = WebViewController()
        
        presentViewController(weiboAuthor, animated: true, completion: nil)
        
    }
    
    func setupUI() {
        
        self.view.addSubview(iconView)
        
        self.view.addSubview(maskIconView)
        
        self.view.addSubview(homeIconView)
        
        self.view.addSubview(messagesLabel)
        
        self.view.addSubview(registerButton)
        
        self.view.addSubview(loginButton)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        iconView.JY_AlignInner(type: JY_AlignType.Center, referView: self.view, size: nil)
        
        maskIconView.JY_Fill(self.view)
        
        homeIconView.JY_AlignInner(type: JY_AlignType.Center, referView: self.view, size: nil)
        
        messagesLabel.jy_AlignVertical(type: JY_AlignType.BottomCenter, referView: iconView, size: nil)
        
        self.view.addConstraint(NSLayoutConstraint(item: messagesLabel, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        registerButton.jy_AlignVertical(type: JY_AlignType.BottmLeft, referView: messagesLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        
        loginButton.jy_AlignVertical(type: JY_AlignType.BottmRight, referView: messagesLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        
    }
    
    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return iv
        
    }()
    
    private lazy var maskIconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return iv
        
    }()
    
    private lazy var homeIconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return iv
        
    }()
    
    private lazy var messagesLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "关注一些人，回这里看看有什么惊喜"
        
        label.textColor = UIColor.darkGrayColor()
        
        label.font = UIFont.systemFontOfSize(14)
        
        label.numberOfLines = 0
        
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var registerButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("注册", forState: .Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        
        return btn
    }()
    
    private lazy var loginButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("登录", forState: .Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        
        btn.addTarget(self, action: "weiboLogin:", forControlEvents: .TouchUpInside)
        
        return btn
        
    }()
    
    func weiboLogin(sender: UIButton) {
        
        let weiboAuthor = WebViewController()
        
        print(weiboAuthor)
        
        navigationController?.pushViewController(weiboAuthor, animated: true)
        
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
