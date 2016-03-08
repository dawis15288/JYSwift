//
//  ViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/1/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var singin: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        checkForExistingAccessToken()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForExistingAccessToken() {
    
        if NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") != nil {
            
            singin.enabled = false
            
            singin.hidden = true
            
            let weiboAccessToken = NSUserDefaults.standardUserDefaults().objectForKey("weiboAccessToken") as! String
            
            //WeiboModal().getWeiboData(3, weiboAccessToken: weiboAccessToken)
        
        }
    
    }
    
    

}

