//
//  TopicsTableViewController.swift
//  JYSplitAndPPopover
//
//  Created by atom on 16/1/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController, XMLParserDelegate {
    
    var xmlParser: XMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = NSURL(string: "http://feeds.feedburner.com/appcoda")
    
        xmlParser = XMLParser()
        
        xmlParser.delegate = self
        
        xmlParser.startParsingWithContentsfURL(url!)
    
    
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
        return xmlParser.arrParserData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath) as UITableViewCell

        let currentDictionary = xmlParser.arrParserData[indexPath.row] as Dictionary<String, String>
        
        cell.textLabel?.text = currentDictionary["title"]

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dictionary = xmlParser.arrParserData[indexPath.row]
        
        let tutorialLink = dictionary["link"]
        
        let publishDate = dictionary["pubDate"]
        
        let tutorialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idTutorialViewController") as! TutorialViewController
        
        tutorialViewController.totorialURL = NSURL(string: tutorialLink!)
        
        tutorialViewController.publishData = publishDate!
        
        showDetailViewController(tutorialViewController, sender: self)
        
    }
    
    func parsingWasFinished() {
        
        self.tableView.reloadData()
        
    }

}
