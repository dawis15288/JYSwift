//
//  ViewController.swift
//  RxSwift
//
//  Created by atom on 16/4/5.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bx = UIView(frame: CGRect(x: 3, y: 3, width: 38, height: 38))
        
        bx.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(bx)
        
        /*bx.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.view).offset(33)
        }*/
        
       //let _ = bx.JY_Fill(view, insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        
        let cn = bx.JY_AlignInner(type: JY_AlignType.TopLeft, referView: view, size: CGSize(width: 38, height: 93), offset: CGPoint(x: 39, y: 69))
        
        let _ = bx.jy_Constraint(cn, attribute: NSLayoutAttribute.Width)
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

