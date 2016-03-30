//
//  ClockViewController.swift
//  JYExtensionProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    var timeLabel: UILabel?
    
    var timer: NSTimer?
    
    let INTERVAL_SECONDS = 0.2
    
    var dateFormatter = NSDateFormatter()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        self.dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        timeLabel = UILabel(frame: self.view.frame)
        
        updateTimeLabel(nil)
        
        timeLabel?.numberOfLines = 0
        
        timeLabel?.textAlignment = .Center
        
        timeLabel?.font = UIFont.systemFontOfSize(28.0)
        
        self.view.addSubview(timeLabel!)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(INTERVAL_SECONDS, target: self, selector: "updateTimeLabel:", userInfo: nil, repeats: true)
        
        
        
    }
    
    func updateTimeLabel(timer: NSTimer!) {
        
        if let label = timeLabel {
            
            let now = NSDate()
            
            let dateString = dateFormatter.stringFromDate(now)
            
            label.text = dateString
        
        }
    
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
