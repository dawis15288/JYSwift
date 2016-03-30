//
//  MasterViewController.swift
//  JYProject32
//
//  Created by atom on 16/2/4.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SafariServices

import CoreSpotlight

import MobileCoreServices

class MasterViewController: UITableViewController {

    var projects = [[String]]()
    
    var favorites = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, NSFileManager, storyboards"])
        projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
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
        
        //进入编辑模式
        
        tableView.editing = true
        //编辑模式 cell依然可点击
        tableView.allowsSelectionDuringEditing = true
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues


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
        
        
        

        cell.textLabel?.attributedText = makeAttributedString(title: "\(project[0])", subTitle: "\(project[1])")
        
        //判断当前cell是否在喜欢数组里面面
        
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
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        if favorites.contains(indexPath.row) {
            
            return .Delete
        
        } else {
        
            return .Insert
        
        }
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Insert {
            
            favorites.append(indexPath.row)
            
            indexItem(indexPath.row)
        
        } else {
            
            if let index = favorites.indexOf(indexPath.row) {
                
                print("index in favorites is \(index)\n")
                
                favorites.removeAtIndex(index)
                
                deindexItem(indexPath.row)
            
            }
        
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(favorites, forKey: "favorites")
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
    }
    
    func indexItem(which: Int) {
        
        let project = projects[which]
        
        //封装属性你想为一个搜索项显示的设置(title Description image...)（即，由cssearchableitem对象表示一个项目）。
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        attributeSet.title = project[0]
        
        attributeSet.contentDescription = project[1]
        
        //首先创建一个属性集包含属性指定要显示的项的搜索结果中的元数据。通常情况下，你想至少设置以下属性：标题、contentdescription，thumbnaildata，等级，和关键词。
        
        let item = CSSearchableItem(uniqueIdentifier: "\(which)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        //搜索过期时间
        item.expirationDate = NSDate.distantFuture()
        //添加item，通过闭包看是否添加成功
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item], completionHandler: { [unowned self] (error) -> Void in
        
            if let error = error {
                
                let ac = UIAlertController(title: "error", message: "Indexing error: \(error.localizedDescription)", preferredStyle: .Alert)
                
                ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                
                self.presentViewController(ac, animated: false, completion: nil)
                
            } else {
                
                let ac = UIAlertController(title: "successfully", message: "Search item successfully indexed!", preferredStyle: .Alert)
                
                ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                
                self.presentViewController(ac, animated: false, completion: nil)
            
            }
        })
    
    }
    
    func deindexItem(which: Int) {
        
        //删除一个item
        
        CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithIdentifiers(["\(which)"], completionHandler: { [unowned self] (error) -> Void in
            
            if let error = error {
                
                let ac = UIAlertController(title: "error", message: "Deindexing error: \(error.localizedDescription)", preferredStyle: .Alert)
                
                ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                
                self.presentViewController(ac, animated: false, completion: nil)
                
            } else {
                
                let ac = UIAlertController(title: "successfully", message: "Search item successfully removed!!", preferredStyle: .Alert)
                
                ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                
                self.presentViewController(ac, animated: false, completion: nil)
                
            }
            
            })
    
    }
    
    //根据cell内容调整cell高度
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    //根据cell内容调整cell高度
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    //设置标题和副标题的文字属性
    func makeAttributedString(title title: String, subTitle: String) -> NSAttributedString {
        
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), NSForegroundColorAttributeName: UIColor.purpleColor()]
        
        let subTitleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        
        let subTitleString = NSMutableAttributedString(string: "\(subTitle)", attributes: subTitleAttributes)
        
        titleString.appendAttributedString(subTitleString)
        
        return titleString
    
    }
    
    func showTutorial(which: Int) {
        
        if let url = NSURL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            
            let vc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
            
            
            presentViewController(vc, animated: false, completion: nil)
        
        }
    
    }

}

