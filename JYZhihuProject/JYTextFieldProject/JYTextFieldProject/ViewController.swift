//
//  ViewController.swift
//  JYTextFieldProject
//
//  Created by atom on 16/3/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NVBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        (self.view.viewWithTag(99)! as UIView).alpha = 0
        
        
        
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if let label = cell.contentView.viewWithTag(88) as? UILabel {
            
            var i = 0
            
            label.text = "i--\(i)"
            
            ++i
        
        }
        
       
        
        return cell
        
        
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let iosSize = UIScreen.mainScreen().bounds
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iosSize.size.width, height: 64))
        
        view.backgroundColor = UIColor.orangeColor()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 24))
        
        label.text = "\(section)"
        
        label.textColor = UIColor.orangeColor()
        
        label.textAlignment = .Right
        
        view.addSubview(label)
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            
            return 0
            
        }
        
        return 44
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0) && (indexPath.row == 9) {
            
            print("\(indexPath.section) -- \(indexPath.row)")
            
            print("\(self.NVBarHeight.constant)")
            
            self.NVBarHeight.constant = 64
        
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0) && (indexPath.row == 9) {
        
            self.NVBarHeight.constant = 20
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        (self.view.viewWithTag(99)! as UIView).alpha = scrollView.contentOffset.y / 400
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

