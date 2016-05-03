//
//  ViewController.swift
//  JYinstance
//
//  Created by atom on 16/4/17.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = DemoClass4.sharedInstance
        
        _ = DemoClass3.sharedInstance
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

