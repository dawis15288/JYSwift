//
//  JYTableViewController.swift
//  JYRefrshDemo
//
//  Created by atom on 16/2/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYTableViewController: UITableViewController {
    
    let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
    
    var dataArray: [String] = ["jy", "dawis", "dd"]
    
    //[Dictionary<String, AnyObject>]
    
    var jsonDatas: [AnyObject] = []
    
    var refreshController: UIRefreshControl!
    
    var custom: UIView!
    
    var labelsArray: Array<UILabel> = []
    
    var isAnimating = false
    
    var currentColorIndex = 0
    
    var currentLabelIndex = 0
    
    var timer: NSTimer!
    
    func animateRefreshSetp1() {
        
        isAnimating = true
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
            
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            
            self.labelsArray[self.currentLabelIndex].textColor = self.getnextColor()
            
            }, completion: { (finished) -> Void in
                
                UIView.animateWithDuration(0.005, delay: 0.0, options: .CurveLinear, animations: {
                    
                    self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformIdentity
                    
                    self.labelsArray[self.currentLabelIndex].textColor = UIColor.blackColor()
                    
                    }, completion: { (finished) -> Void in
                        
                        ++self.currentLabelIndex
                        
                        if self.currentLabelIndex < self.labelsArray.count {
                            
                            self.animateRefreshSetp1()
                        
                        } else {
                            
                            self.animateRefreshSetp2()
                        
                        }
                
                })
        
        })
    
    }
    
    func animateRefreshSetp2() {
        
        UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveLinear, animations: {
            
                self.labelsArray[0].transform = CGAffineTransformMakeScale(2.0, 2.0)
            
                self.labelsArray[1].transform = CGAffineTransformMakeScale(2.0, 2.0)
            
                self.labelsArray[2].transform = CGAffineTransformMakeScale(2.0, 2.0)
            
                self.labelsArray[3].transform = CGAffineTransformMakeScale(2.0, 2.0)
            
            }, completion: { (finished) -> Void in
        
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveLinear, animations: {
                    
                    self.labelsArray[0].transform = CGAffineTransformIdentity
                    
                    self.labelsArray[1].transform = CGAffineTransformIdentity
                    
                    self.labelsArray[2].transform = CGAffineTransformIdentity
                    
                    self.labelsArray[3].transform = CGAffineTransformIdentity
                    
                    }, completion: {(finished) -> Void in
                        
                        if self.refreshController.refreshing {
                            
                            self.currentLabelIndex = 0
                            
                            self.animateRefreshSetp1()
                        
                        } else {
                        
                            self.isAnimating = false
                            
                            self.currentLabelIndex = 0
                            
                            for var  i = 0; i < self.labelsArray.count; ++i {
                                
                                self.labelsArray[i].textColor = UIColor.blackColor()
                                
                                self.labelsArray[i].transform = CGAffineTransformIdentity
                            
                            }
                        
                        }
                
                })
        
        })
    
    }
    
    func getnextColor() -> UIColor {
        
        var colorArray: Array<UIColor> = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor(), UIColor.brownColor()]
        
        if currentColorIndex == colorArray.count {
            
            currentColorIndex = 0
        
        }
        
        let returnColor = colorArray[currentColorIndex]
        
        ++currentColorIndex
        
        return returnColor
    
    }
    
    func doSomthing() {
    
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    
    }
    
    func endOfWork() {
        
        print(timer)
        
        guard let url = NSURL(string: postEndpoint) else { return }
        
        let request = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self] (data, response, error) -> Void in
            
            if (response as! NSHTTPURLResponse).statusCode == 200 {
                
                guard let datas = data else { return }
                
                do {
                
                    self.jsonDatas = try NSJSONSerialization.JSONObjectWithData(datas, options: .MutableContainers) as! Array
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.tableView.reloadData()
                        
                        self.refreshController.endRefreshing()
                        
                        self.timer.invalidate()
                        
                        self.timer = nil
                    
                    })
                
                } catch _ {
                
                    
                }
            
            }
        
        
        })
        
        task.resume()
        
        
        
        //insertLoveData()
    
    }
    
    func insertLoveData() {
        
        let lastIndexPath = NSIndexPath(forItem: dataArray.count, inSection: 0)
        
        dataArray.append("swifter")
        
        tableView.beginUpdates()
        
        tableView.insertRowsAtIndexPaths([lastIndexPath], withRowAnimation: .Middle)
        
        tableView.endUpdates()
    
    }
    
    
    func loadCustomRefreshContents() {
        
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        
        refreshController = UIRefreshControl()
        
        custom = refreshContents[0] as! UIView
        
        custom.frame = refreshController.bounds
        
        for var i = 0; i < custom.subviews.count; i++ {
            
             let label = custom.viewWithTag(i + 1) as! UILabel
            
            labelsArray.append(label)
            
        
        }
        
        refreshController.addSubview(custom)
    
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if refreshController.refreshing {
            
            if !isAnimating {
                
                doSomthing()
                
                animateRefreshSetp1()
            
            }
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       /*
        
        refreshController.backgroundColor = UIColor.redColor()
        
        refreshController.tintColor = UIColor.yellowColor() */
        
        loadCustomRefreshContents()
        
        tableView.addSubview(refreshController)
        
        //refreshController.beginRefreshing()
        
        //animateRefreshSetp1()
        
        //doSomthing()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonDatas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = jsonDatas[indexPath.row]["title"] as? String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
