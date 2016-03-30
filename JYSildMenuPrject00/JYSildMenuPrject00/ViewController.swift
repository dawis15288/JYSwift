//
//  ViewController.swift
//  JYSildMenuPrject00
//
//  Created by atom on 16/2/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuTableView: UITableView!
    
    let menuIcons = ["asl", "asl", "asl", "asl", "asl", "asl"]
    
    var isSgow = false
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let cells = menuTableView.visibleCells
        
        for cell in cells {
            
            cell.frame.origin = CGPoint(x: -80, y: cell.frame.origin.y)
        
        }
    }
    @IBAction func trigger(sender: AnyObject) {
        
        print(sender)
        
        menuStartChange()
        
    }
    @IBAction func swipe(sender: AnyObject) {
        
        if let sender = sender as? UISwipeGestureRecognizer {
            
            if sender.direction == UISwipeGestureRecognizerDirection.Left && isSgow == true {
                
                menuStartChange()
            
            } else if sender.direction == UISwipeGestureRecognizerDirection.Right && isSgow == false {
                
                menuStartChange()
            
            }
        
        }
    }
    
    func menuStartChange() {
        
        let cells = menuTableView.visibleCells
        
        let diff = 0.5
        
        if isSgow == false {
            
            for cell in cells {
                
                print(cell)
                
                cell.frame.origin = CGPoint(x: 0, y: cell.frame.origin.y)
                
                
            }
            
            for i in 0 ..< cells.count {
                
                let cell = cells[i]
                
                print(i)
                
                UIView.animateWithDuration(0.3, delay: Double(i + 1 ) * diff, options: .CurveLinear, animations: { () -> Void in
                    
                        cell.frame.origin = CGPoint(x: -80, y: cell.frame.origin.y)
                    
                    }, completion: nil)
            
            }
        
        } else {
            
            for cell in cells {
                
                print(cell)
                
                cell.frame.origin = CGPoint(x: -80, y: cell.frame.origin.y)
                
                
            }
            
            for i in 0 ..< cells.count {
                
                let cell = cells[i]
                print(i)
                
                UIView.animateWithDuration(0.3, delay: Double(i + 1 ) * diff, options: .CurveLinear, animations: { () -> Void in
                    
                    cell.frame.origin = CGPoint(x: 0, y: cell.frame.origin.y)
                    
                    }, completion: nil)
                
            }
        
        }
        
        isSgow = !isSgow
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: datasource delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuIcons.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath:  indexPath)
        
        let menuImageView = cell.viewWithTag(715) as! UIImageView
        
        menuImageView.image = UIImage(named: menuIcons[indexPath.row])
        
        return cell
        
    }


}

