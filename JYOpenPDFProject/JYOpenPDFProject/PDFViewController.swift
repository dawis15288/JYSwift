//
//  PDFViewController.swift
//  JYOpenPDFProject
//
//  Created by atom on 16/2/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let url = NSBundle.mainBundle().URLForResource("CloudReadyforIndividuals", withExtension: "pdf")
        
        print(url)
        
        if let url = url {
            
            print(url)
            
            webView.backgroundColor = UIColor.blueColor()
            
            let request = NSURLRequest(URL: url)
            
            webView.loadRequest(request)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
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
