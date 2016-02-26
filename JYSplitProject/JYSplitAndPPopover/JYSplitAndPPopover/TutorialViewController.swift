//
//  TutorialViewController.swift
//  JYSplitAndPPopover
//
//  Created by atom on 16/1/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    var totorialURL: NSURL!
    
    var publishData: String!
    
    var tutorialsButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.hidden = true
        
        toolBar.hidden = true
        
        tutorialsButtonItem = UIBarButtonItem(title: "Tutorials", style: .Plain, target: self, action: "showTutorialsViewController:")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleFirstViewControllerDisplayModeChangeWithNotification:"), name: "PrimaryVCDisplayModeChangeNotification", object: nil)
        
        
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification) {
        
        let displayModeObject = notification.object as? NSNumber
        
        let nextDisplayMode = displayModeObject?.integerValue
        
        if toolBar.items?.count == 3 {
            
            toolBar.items?.removeAtIndex(0)
        
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            
            toolBar.items?.insert(tutorialsButtonItem, atIndex: 0)
        
        } else {
            
            toolBar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        
        }
    
    }
    
    func showTutorialsViewController(sender: UIBarButtonItem) {
        
        splitViewController?.preferredDisplayMode = .AllVisible
    
    
    
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let tutorialURL = totorialURL {
            
            let request: NSURLRequest = NSURLRequest(URL: tutorialURL)
            
            webView.loadRequest(request)
            
            if webView.hidden {
                
                webView.hidden = false
                
                toolBar.hidden = false
                
            }
            
            if self.traitCollection.verticalSizeClass == .Compact {
                
                toolBar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            
            }
        
        }
        
    }

    @IBAction func showPublishDate(sender: AnyObject) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idopoverVC") as! JYPopoverViewController
        vc.modalPresentationStyle = .Popover
        
        if let popover = vc.popoverPresentationController {
            
            popover.delegate = self
            
            popover.barButtonItem = pubDateButtonItem
            
            popover.permittedArrowDirections = .Any
            
        }
        
        vc.preferredContentSize = CGSizeMake(200.0, 80.0)
        
        presentViewController(vc, animated: true, completion: { () -> Void in
            
            
            
            vc.popoverDate.text = "Publish Date:\n\(self.publishData)"
            
            print(self.publishData)
            
        
        })
        
        
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        
        
        if previousTraitCollection?.verticalSizeClass == .Compact {
            
            print("verticalSizeClass Compact")
            
            let firstItem = toolBar.items?[0]
            
            if firstItem?.title == "Tutorials" {
                
                
                let item0 = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: Selector("printMessage:"))
                
                
                toolBar.items?.removeAtIndex(0)
                
                toolBar.items?.insert(item0, atIndex: 0)
            
            }
            
        } else if previousTraitCollection?.verticalSizeClass == .Regular {
            
            print("verticalSizeClass Regular")
        
            if toolBar.items?.count == 3 {
                
                toolBar.items?.removeAtIndex(0)
            
            }
            
            if splitViewController?.displayMode == .PrimaryHidden {
                
                toolBar.items?.insert(tutorialsButtonItem, atIndex: 0)
            
            } else {
                
                toolBar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            
            }
        
        }
        
        
    }
    
    func printMessage(sennder: UIBarButtonItem) {
        
        print(sennder)
    
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
