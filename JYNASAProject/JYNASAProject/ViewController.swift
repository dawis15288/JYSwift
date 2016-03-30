//
//  ViewController.swift
//  JYNASAProject
//
//  Created by atom on 16/2/17.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let apiController = APIController()
        
        let today = NSDate()
        
        let yesterday = today.dateByAddingTimeInterval(-1*24*60*60*15)
        
        print(today)
        
        apiController.getAPOD(yesterday)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

