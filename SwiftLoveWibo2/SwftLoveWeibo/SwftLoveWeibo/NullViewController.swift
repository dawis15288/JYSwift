//
//  NullViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/8.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class NullViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.因为没有加载这个控制器！\
        
        /*
        
        let jyPopoverVC = JYPopoverViewController()
        
        jyPopoverVC.modalPresentationStyle = .Popover
        
        jyPopoverVC.preferredContentSize = CGSizeMake(80, 100)
        
        if let popover = jyPopoverVC.popoverPresentationController {
        
        popover.delegate = self
        
        popover.barButtonItem = navigationItem.rightBarButtonItem
        
        popover.permittedArrowDirections = .Any
        
        }
        
        
        
        presentViewController(jyPopoverVC, animated: true, completion: { () -> Void in
        
        jyPopoverVC.view.backgroundColor = UIColor.grayColor()
        
        let frame1 = CGRectMake(10, 10, 60, 10)
        
        let label1 = UILabel(frame: frame1)
        
        label1.text = "label1"
        
        let frame2 = CGRectMake(10, 25, 60, 10)
        
        let label2 = UILabel(frame: frame2)
        
        label2.text = "label2"
        
        jyPopoverVC.view.addSubview(label1)
        
        jyPopoverVC.view.addSubview(label2)
        
        })
        
        */
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
