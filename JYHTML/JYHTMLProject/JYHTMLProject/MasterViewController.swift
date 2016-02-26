//
//  MasterViewController.swift
//  JYHTMLProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    
    var dataController = DataController()
    
    var docController: UIDocumentInteractionController?

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    var timer: NSTimer!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        dataController.fetchCharts { _ in
            
            self.tableView.reloadData()
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.charts?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let jyCell = cell as? JYCell {
            
            if let chart = dataController.charts?[indexPath.row] {
                
                if self.dataController.isChartDownloaded(chart) {
                    
                    jyCell.accessoryType = .Checkmark
                    
                }
                
                jyCell.title.text = "\(chart.number): \(chart.title)"
                
            } else {
                
                jyCell.title.text = "JY"
            }
            
            return jyCell
        
        }

        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let chart = dataController.charts?[indexPath.row] {
            
            dataController.downloadChart(chart) { progress, error in
                
                print("didSelectRowAtIndexPath  ---->> \(progress)")
                
                //print(error)
                
                if progress < 1.0 {
                    
                    if let cell = self.tableView.cellForRowAtIndexPath(indexPath), jyCell = cell as? JYCell, progressValue = progress {
                        
                        jyCell.progressBar.hidden = false
                        
                        jyCell.progressBar.progress += Float(progressValue)
                        
                        self.timer = NSTimer(timeInterval: 5.0, target: self, selector: "showProgress", userInfo: nil, repeats: true)
                        
                        jyCell.setNeedsDisplay()
                    
                    }
                
                }
                
                if (progress == 1.0) {
                    
                    if let filename = chart.filename {
                        
                        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                        
                        let docs = paths[0]
                        
                        let pathURL = NSURL(fileURLWithPath: docs, isDirectory: true)
                        
                        let fileURL = NSURL(fileURLWithPath: filename, isDirectory: false, relativeToURL: pathURL)
                        
                        self.docController = UIDocumentInteractionController(URL: fileURL)
                        
                        self.docController?.delegate = self
                        
                        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
                            
                            print(cell)
                            
                            self.docController?.presentOptionsMenuFromRect(cell.frame, inView: self.tableView, animated: true)
                            
                            if let jyCell = cell as? JYCell {
                                
                                jyCell.accessoryType = .Checkmark
                                
                                jyCell.setNeedsDisplay()
                            
                            }
                        
                        }
                    
                    }
                
                }
            
            
            }
        
        }
    }
    
    func showProgress() {
        
        
    
    }
    
    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        
        self.docController = nil
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            print("tableView.deselectRowAtIndexPath")
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

