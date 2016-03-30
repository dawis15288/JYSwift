//
//  ViewController.swift
//  JYProject03
//
//  Created by atom on 16/1/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "sharedTapped:")
    
    
    }
    
    func sharedTapped(sender: UIBarButtonItem) {
        
        let image = UIImage(named: "nssl0033")
        
       /* let vc = UIActivityViewController(activityItems: [image!], applicationActivities: [])
        
        presentViewController(vc, animated: true, completion: { () -> Void in
        
            print("ok")
        
        })*/
    
            let slVC = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        
            slVC.addImage(image)
        
            slVC.setInitialText("weibo")
        
            slVC.addURL(NSURL(string: "http://weibo.com"))
        
        
        presentViewController(slVC, animated: true, completion: nil)
        
        
        
        
       // slVC.setInitialText("Look ar this great pictrue!")
        
        //slVC.addImage(image)
        
        //slVC.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        
        
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

