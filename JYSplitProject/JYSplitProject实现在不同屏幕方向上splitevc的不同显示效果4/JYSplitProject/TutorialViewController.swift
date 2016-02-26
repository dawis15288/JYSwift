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
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if tutoriaURL != nil {
            
            let request = NSURLRequest(URL: tutoriaURL)
            
            webView.loadRequest(request)
            
            if webView.hidden {
                
                webView.hidden = false
                
                toolbar.hidden = false
            
            }
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.hidden = true
        
        toolbar.hidden = true
        
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
