//
//  TutorialViewController.swift
//  JYSplitProject
//
//  Created by atom on 16/2/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    var tutoriaURL: NSURL!
    
    var tutorialsButtonItem: UIBarButtonItem!
    
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
