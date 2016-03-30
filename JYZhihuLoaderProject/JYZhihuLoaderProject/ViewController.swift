//
//  ViewController.swift
//  JYZhihuLoaderProject
//
//  Created by atom on 16/2/26.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cycleLoadView: JYCycleLoaderView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //cycleLoadView.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cycleLoadView.startAnimation()
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 80 ))
        
        print("\(popTime)")
        
        dispatch_after(popTime, dispatch_get_main_queue(), { [unowned self ] () -> Void in
            
            self.cycleLoadView.stopAnimation()
        
        })
        
        
    }


}

