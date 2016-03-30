//
//  ViewController.swift
//  JYSlideMenu
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuTransitionManagerDelegate {
    
    let menuTransitionManager = MenuTransitionManager()
    
    @IBOutlet weak var tableView: UITableView!
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Everyday moments"
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.backgroundColor = UIColor(red: 0.062, green: 0.062, blue: 0.07, alpha: 1)
        
    }
    
    func dismiss() {
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! JYNewsCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        if indexPath.row == 0 {
            
            cell.postImageView.image = UIImage(named: "1")
            
            cell.postTitle.text = "Love mountain."
            
            cell.postAuthor.text = "JY"
            
            cell.authorImageView.image = UIImage(named: "a")
        
        } else if indexPath.row == 1 {
            
            cell.postImageView.image = UIImage(named: "2")
            
            cell.postTitle.text = "New graphic design - LIVE FREE"
            
            cell.postAuthor.text = "Cole"
            
            cell.authorImageView.image = UIImage(named: "b")
        
        } else if indexPath.row == 2 {
            
            cell.postImageView.image = UIImage(named: "3")
            
            cell.postTitle.text = "Summer sand"
            
            cell.postAuthor.text = "Daniel Hooper"
            
            cell.authorImageView.image = UIImage(named: "c")
        
        } else {
            
            cell.postImageView.image = UIImage(named: "4")
            cell.postTitle.text = "Seeking for signal"
            cell.postAuthor.text = "Noby-Wan Kenobi"
            cell.authorImageView.image = UIImage(named: "d")
        
        }
        
        return cell
        
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
        let sourceController = segue.sourceViewController as! MenuTableViewController
        
        print(sourceController.currentItem)
        
        self.title = sourceController.currentItem
    
    }
    
    @IBAction func windToHome(segue: UIStoryboardSegue) {
        
        print("some")
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let menuTableViewController = segue.destinationViewController as! MenuTableViewController
        
        print("menuTableViewController ----------> viewController")
        
        menuTableViewController.currentItem = self.title!
        
        menuTableViewController.transitioningDelegate = menuTransitionManager
        
        menuTransitionManager.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

