//
//  JYImageViewController.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYImageViewController: UIViewController {
    
    @IBOutlet weak var bigImage: UIImageView!
    var imageURL: String = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "图片"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
