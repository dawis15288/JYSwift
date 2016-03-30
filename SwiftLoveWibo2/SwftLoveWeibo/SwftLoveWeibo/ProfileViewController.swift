//
//  ProfileViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupUIs()
        
    }
    
    private func setupUIs() {
        
       // view.addSubview(proImageView)
        
       // view.addSubview(iconView)
        
        //let width = UIScreen.mainScreen().bounds.width
        
        //proImageView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: width, height: 200),offset: CGPoint(x: 0, y: -10))
        
        //iconView.JY_AlignInner(type: JY_AlignType.TopCenter, referView: proImageView, size: CGSize(width: 100, height: 100), offset: CGPoint(x: 30, y: 0))
        
        //navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        
       //if let imageURLString = NSUserDefaults.standardUserDefaults().objectForKey("userAvatar_large") as? String {
            
           // self.iconView.setJYImageWithURL(imageURLString)
        //}
    
    }
    
    //guard else { return "http://ww3.sinaimg.cn/crop.0.294.980.245/67e98968tw1dwn10biucyj.jpg" }
    
    private lazy var proImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        if let url = UserAccount.loadAccount()?.cover_image_phone {
        
            if let imageURL = NSURL(string: url) {
                
                imageView.sd_setImageWithURL(imageURL)
                
            }
        }
        
        
        
        return imageView
    
    }()
    
    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        iv.layer.cornerRadius = 50
        
        iv.layer.masksToBounds = true
        
        
        
        return iv
        
    }()

}
