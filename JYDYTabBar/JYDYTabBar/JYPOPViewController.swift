//
//  JYPOPViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

protocol JYPOPViewControllerDelegate {
    
    func closeView()
}

class JYPOPViewController: UIViewController {
    
    var backClosure: (() -> Void)?
    
    var delegate: JYPOPViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
        
        setupUIs()
    }
    
    
    private func setupUIs() {
        
        self.view.addSubview(closebutton)
        
        self.view.addSubview(pushbutton)
        
        
        self.view.addSubview(solganImageView)
        
        self.view.addSubview(videobutton)
        
        self.view.addSubview(audiobutton)
        
        self.view.addSubview(offlinebutton)
        
        self.view.addSubview(reviewbutton)
        
        self.view.addSubview(picturebutton)
        
        let solganX = 90
        
        let solganY = 125
        
        let solganSize = CGSize(width: 212, height: 30)
        
        solganImageView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: solganSize, offset: CGPoint(x: solganX, y: solganY))
        
        let size = CGSize(width: 97, height: 97)
        
        /** marginX 左边*/
        
        let marginx = 26
        
        /** marginX 上下*/
        
        let marginY = 30
        
        /** marginTop 左上角按钮顶部距离*/
        
        let marginTop = 195
        
        pushbutton.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: size, offset: CGPoint(x: marginx, y: marginTop ))
        
       
        
        audiobutton.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: pushbutton, size: size, offset: CGPoint(x: marginx, y: 0))
        
        picturebutton.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: audiobutton, size: size, offset: CGPoint(x: marginx, y: 0))
        
        reviewbutton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pushbutton, size: size, offset: CGPoint(x: 0, y: marginY))
        
        offlinebutton.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: reviewbutton, size: size, offset: CGPoint(x: marginx, y: 0))
        
        videobutton.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: offlinebutton, size: size, offset: CGPoint(x: marginx, y: 0))
        
        closebutton.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: self.view, size: nil, offset: CGPoint(x: 155, y: -30))
    
    }
    
    
    
    
    
    
    
    
    private lazy var closebutton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("关闭视图", forState: .Normal)
        
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        print(button.frame)
        
        button.addTarget(self, action: #selector(closeVC), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    
    }()
    
    private lazy var pushbutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-text"), forState: UIControlState.Normal)
        
        button.setTitle("新段子", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
    
        return button
        
    }()
    
    private lazy var videobutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-video"), forState: UIControlState.Normal)
        
        button.setTitle("新视频", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
        
        return button
        
    }()
    
    private lazy var audiobutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-audio"), forState: UIControlState.Normal)
        
        button.setTitle("新声音", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
        
        return button
        
    }()
    
    private lazy var offlinebutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-offline"), forState: UIControlState.Normal)
        
        button.setTitle("新离线", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
        
        return button
        
    }()
    
    private lazy var picturebutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-picture"), forState: UIControlState.Normal)
        
        button.setTitle("新图片", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
        
        return button
        
    }()
    
    private lazy var reviewbutton: JYverticonButton = {
        
        let button = JYverticonButton()
        
        button.setImage(UIImage(named: "publish-review"), forState: UIControlState.Normal)
        
        button.setTitle("新预览", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        
        
        return button
        
    }()
    
    private lazy var solganImageView: UIImageView = {
    
        let solganImageView = UIImageView()
        
        solganImageView.image = UIImage(named: "app_slogan")
        
        return solganImageView
    
    }()
    
    
    func closeVC() {
    
        print(closebutton.frame)
        
        /*let window = UIApplication.sharedApplication().windows.first
        
        window?.rootViewController = JYTabBarViewController()
        
        window?.makeKeyAndVisible()*/
        
        self.delegate?.closeView()
        
        dismissViewControllerAnimated(true) { 
            
            
            
        }
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
