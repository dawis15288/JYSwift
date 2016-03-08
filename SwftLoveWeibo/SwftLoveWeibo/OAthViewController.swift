//
//  OAthViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/5.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SVProgressHUD

class OAthViewController: UIViewController {
    
    private let WB_Client_ID = ""
    
    private let WB_REDIRECT_URI = ""
    
    private let WB_REDIRECT_URL = ""
    
    private lazy var webView: UIWebView = {
        
        let wv = UIWebView()
        
        wv.delegate = self
        
        return wv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close() {
        
        dismissViewControllerAnimated(true, completion: nil)
    
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

extension OAthViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL?.absoluteString
        
        if !urlString!.hasPrefix(WB_REDIRECT_URL){
            
            return true
        
        }
        
        let query = request.URL?.query
        
        let codeString = "code="
        
        if query!.hasPrefix(codeString) {
            
            let code = query!.substringFromIndex(codeString.endIndex)
            
            print(code)
        
        } else {
        
            close()
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        
    }

}
