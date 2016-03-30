//
//  JYViewController.swift
//  JYPullRefrshProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var refreshController = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshController.backgroundColor = UIColor.clearColor()
        
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.refreshController.attributedTitle = NSAttributedString(string: "Last update on \(NSDate())", attributes: attributes)
        
        self.refreshController.tintColor = UIColor.whiteColor()
        
        self.title = "emoji"
        
        self.tableView.addSubview(refreshController)
        
    }
    
    func refresh(sender: AnyObject) {
        
        self.loadStockQuoteItems()
        
    }
    
    func loadStockQuoteItems() {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Label"
        
        return cell
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
