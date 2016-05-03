//
//  MasterViewController.swift
//  Project32
//
//  Created by atom on 15/11/22.
//  Copyright © 2015年 atom. All rights reserved.
//

import UIKit

import SafariServices

import CoreSpotlight

import MobileCoreServices

class MasterViewController: UITableViewController {
    
    //var objects = [AnyObject]()
    
    var projects = [[String]]()
    
    var favorites = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, NSFileManager, storyboards"])
        
        projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+=, ++, and --), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
        
        projects.append(["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, NSURL"])
        
        projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, NSURLRequest, UIToolbar, UIProgressView., key-value observing"])
        
        projects.append(["Project 5: Word Scramble", "NSString, closures, method return values, booleans, NSRange"])
        
        projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
        
        projects.append(["Project 7: Whitehouse Petitions", "JSON, NSData, UITabBarController"])
        
        projects.append(["Project 8: 7 Swifty Words", "addTarget(), enumerate(), countElements(), find(), join(), property observers, range operators."])
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedFavorites = defaults.objectForKey("favorites") as? [Int] {
            
            favorites = savedFavorites
        
        }
        
        tableView.editing = true
        
        tableView.allowsSelectionDuringEditing = true
        
        
    }

    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
       /* objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)*/
    }

    // MARK: - Segues

    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        
    }*/

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return projects.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let project = projects[indexPath.row]
        
        //cell.textLabel?.text = "\(project[0]): \(project[1])"
        
         cell.textLabel?.attributedText = makeAttributedString(title: project[0], subTitle: project[1])
        
        if favorites.contains(indexPath.row) {
            
            cell.editingAccessoryType = .Checkmark
        
        } else {
            
            cell.editingAccessoryType = .None
        
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        showTutorial(indexPath.row)
        
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Insert {
            
            favorites.append(indexPath.row)
            
            indexitem(indexPath.row)
        
        } else {
            
            if let index = favorites.indexOf(indexPath.row) {
                
                favorites.removeAtIndex(index)
                
                deindexitem(indexPath.row)
            
            }
        
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(favorites, forKey: "favorites")
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        
    }
    
    func indexitem(which: Int) {
        
        let project = projects[which]
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        attributeSet.title = project[0]
        
        attributeSet.contentDescription = project[1]
        
        let item = CSSearchableItem(uniqueIdentifier: "\(which)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        
        item.expirationDate = NSDate.distantFuture()
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]){ (error: NSError?) ->  Void in
            
            if let error = error {
                
                print("Indexing error: \(error)")
            
            } else {
                
                print("Search item successfully indexed!")
            
            }
        
        }
    
    }
    
    func deindexitem(which: Int) {
        
        CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithIdentifiers(["\(which)"]){ (error: NSError?) -> Void in
            
            if let error = error {
                
                print("Deindexing error: \(error.localizedDescription)")
            
            } else {
                
                print("Search item successfully indexed!")
            
            }
            
        
        }
        
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        if favorites.contains(indexPath.row) {
            
            return .Delete
        
        } else {
            
            return .Insert
        
        
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func makeAttributedString(title title: String, subTitle: String) -> NSAttributedString {
        
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), NSForegroundColorAttributeName: UIColor.purpleColor()]
        
        let subTitleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        
        let subTitleString = NSMutableAttributedString(string: subTitle, attributes: subTitleAttributes)
        
        titleString.appendAttributedString(subTitleString)
        
        return titleString
    
    
    }
    
    func showTutorial(which: Int) {
        
        if let url = NSURL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            
            let vc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
            
            presentViewController(vc, animated: true, completion: nil)
        
        }
    
    
    }


}
