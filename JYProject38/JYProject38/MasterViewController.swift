//
//  MasterViewController.swift
//  JYProject38
//
//  Created by atom on 16/2/12.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    //var objects = [AnyObject]()
    
    var objects = [Commit]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    let dateFormatISO8601 = "yyyy-MM-dd'T'HH:mm:ss'Z'"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        startCoreData()
        
        loadSavedData()
        
        performSelectorInBackground("fetchCommits", withObject: nil)
    }
    
    //https://api.github.com/repos/apple/swift/commits?per_page=100 
    
    func fetchCommits() {
        
        if let url =  NSURL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100") {
            
            let request = NSURLRequest(URL: url)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { ( data, response, error) -> Void in
            
                if (response as! NSHTTPURLResponse).statusCode == 200 {
                    
                    let jsonCommits = JSON(data: data!)
                    
                    let jsonCommitArray = jsonCommits.arrayValue
                    
                    print("Received \(jsonCommitArray.count) new commits.")
                    
                    dispatch_async(dispatch_get_main_queue(), { [unowned self] () -> Void in
                        
                            for jsonCommit in jsonCommitArray {
                                
                                if let commit = NSEntityDescription.insertNewObjectForEntityForName("Commit", inManagedObjectContext: self.managedObjectContext) as? Commit {
                                    
                                    self.configureCommit(commit, usingJSON: jsonCommit)
                                
                                }
                            
                                print("\(jsonCommit)")
                            
                            }
                        
                            self.saveContext()
                        
                            self.loadSavedData()
                        
                        })
                
                }
            
            })
            
            task.resume()
        
        }
        
        
    
        
        /*if let data = NSData(contentsOfURL: NSURL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100")!) {
            
            let jsonCommits = JSON(data: data)
            
            let jsonCommitArray = jsonCommits.arrayValue
            
            print("Received \(jsonCommitArray.count) new commits.")
            
            dispatch_async(dispatch_get_main_queue(), { [ unowned self ]() -> Void in
                
                    for jsonCommit in jsonCommitArray {
                    
                        print("\(jsonCommit)")
                
                    }
                
                    self.saveContext()
                
                })
        
        }*/
    }
    
    func configureCommit(commit: Commit, usingJSON json: JSON) {
        
        commit.sha = json["sha"].stringValue
        
        commit.message = json["commit"]["message"].stringValue
        
        commit.url = json["html_url"].stringValue
        
        let formatter = NSDateFormatter()
        
        formatter.timeZone = NSTimeZone(name: "UTC")
        
        formatter.dateFormat = dateFormatISO8601
        
        commit.date = formatter.dateFromString(json["commit"]["committer"]["date"].stringValue) ?? NSDate()
        
        //self.tableView.reloadData()
        
    }
    
    func loadSavedData() {
        
        let fetch = NSFetchRequest(entityName: "Commit")
        
        let sort = NSSortDescriptor(key: "date", ascending: false)
        
        fetch.sortDescriptors = [sort]
        
        do {
            
            if let commits = try managedObjectContext.executeFetchRequest(fetch) as? [Commit] {
                
                print("\(commits)")
                
                objects = commits
                
                tableView.reloadData()
            
            }
        
        } catch {
        
            print("fetch failed!")
        
        }
    
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startCoreData() {
        
        let modelURL = NSBundle.mainBundle().URLForResource("JYProject38", withExtension: "momd")!
        
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let url = getDocumentsDirectory().URLByAppendingPathComponent("JYProject38.sqlite")
        
        do {
            
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            
            managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    
    func saveContext() {
        
        if managedObjectContext.hasChanges {
            
            do {
                
                try managedObjectContext.save()
            
            } catch {
            
                print("An error occurred while saving")
                
                return
                
            }
        
        }
    
    }
    
    func getDocumentsDirectory() -> NSURL {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls[0]
    
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.message
        
        cell.detailTextLabel?.text = object.date.description
        return cell
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

