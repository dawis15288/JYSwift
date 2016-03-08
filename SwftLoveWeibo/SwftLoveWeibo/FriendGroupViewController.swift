//
//  FriendGroupViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/4.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class FriendGroupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let identifer: String = "customCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension FriendGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }


}