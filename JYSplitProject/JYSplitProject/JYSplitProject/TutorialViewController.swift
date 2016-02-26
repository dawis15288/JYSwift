//
//  TutorialViewController.swift
//  JYSplitProject
//
//  Created by atom on 16/2/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    var tutoriaURL: NSURL!
    
    var tutorialsButtonItem: UIBarButtonItem!
    
    var publishDate: String!
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if tutoriaURL != nil {
            
            let request = NSURLRequest(URL: tutoriaURL)
            
            webView.loadRequest(request)
            
            if webView.hidden {
                
                webView.hidden = false
                
                toolbar.hidden = false
            
            }
            //当屏幕方向在横屏的时候，显示能隐藏主视图的按钮在工具栏上面
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
                
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            
                
            }
        
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleFirstViewControllerDisplayModeChangeWithNotification:"), name: "PrimaryVCDisplayModeChangeNotification", object: nil)
        
    }
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification) {
        
        let displayModeObject = notification.object as? NSNumber
        
        
        let nextDisplayMode = displayModeObject?.integerValue
        
        if toolbar.items?.count == 3 {
            
            toolbar.items?.removeAtIndex(0)
        
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            
            toolbar.items?.insert(tutorialsButtonItem, atIndex: 0)
        
        } else {
        
            toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.hidden = true
        
        toolbar.hidden = true
        
        tutorialsButtonItem = UIBarButtonItem(title: "Tutorials", style: .Plain, target: self, action: "showTutorialsViewController:")
        
    }
    
    func showTutorialsViewController(sender: UIBarButtonItem) {
        
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    
    }
    
    
    @IBAction func showPublishDate(sender: UIBarButtonItem) {
        
        let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as? PopoverViewController
        
        popoverViewController?.modalPresentationStyle = .Popover
        
        popoverViewController?.preferredContentSize = CGSizeMake(200.0, 100.0)
        
        if let popover = popoverViewController?.popoverPresentationController {
            
            popover.delegate = self
            
            //设置箭头方向 视图控制器应该首先提出为了创建演示控制器UIKit。所有的属性，我们需要访问属于演示控制器，它不存在，直到上述段的最后一行被执行。
            //popover.barButtonItem = sender
            
           // popover.permittedArrowDirections = UIPopoverArrowDirection.Any
            
            popover.sourceRect = CGRectMake(100, 100, 200, 100)
            
            popover.sourceView = view
            
        
        }
        
        presentViewController(popoverViewController!, animated: true, completion: { [unowned self] () -> Void in
            
            popoverViewController?.lblMessage.text = "\(self.publishDate)"
        
        })
    }
    
    //实现气泡的自定义大小
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
        
    }

   //在屏幕方向发生变化的时候显示隐藏toolbar上面的item
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        
        if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            let firstItem = toolbar.items?[0]
            
            if firstItem?.title == "Tutorials" {
            
                toolbar.items?.removeAtIndex(0)
            }
        
        } else if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Regular {
            
            if toolbar.items?.count == 3 {
                
                toolbar.items?.removeAtIndex(0)
            
            }
            
            if splitViewController?.displayMode == UISplitViewControllerDisplayMode.PrimaryHidden {
                
                toolbar.items?.insert(tutorialsButtonItem, atIndex: 0)
            
            } else {
                
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            
            }
        
        }
    }

}
