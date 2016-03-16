//
//  DiscoverViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let label = UITextField(frame: CGRectZero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "label"
        
        label.backgroundColor = UIColor.clearColor()
        
        label.selected = false
        
        let textFild = UITextField(frame: CGRectZero)
        
        textFild.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        view.addSubview(textFild)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-[textField(>=100)]-|", options: .AlignAllBaseline, metrics: nil, views: ["label": label, "textField": textFild])
        
        NSLayoutConstraint.activateConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[textField]-|", options: .AlignAllCenterX, metrics: nil, views: ["textField": textFild])
        
        NSLayoutConstraint.activateConstraints(verticalConstraints)
        
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
