//
//  WebViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/1/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    let weiboKey = "1227520346"
    
    let weiboSecret = "097fecf20a2cca6495bd35d2d0c2d7dd"
    
    //https://api.weibo.com/oauth2/authorize
    
    let authorizationEndPoint = "https://open.weibo.cn/oauth2/authorize"
    
    let accessTokenEndPoint = "https://api.weibo.com/oauth2/access_token"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.delegate = self
        
        startAuthorization()
        
    }
    @IBAction func dismiss(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.URL!
        
        if url.host == "api.weibo.com" {
            
            if url.absoluteString.rangeOfString("code") != nil {
                
                let urlParts = url.absoluteString.componentsSeparatedByString("?")
                
                print("urlParts = \(urlParts)")
                
                let code = urlParts[1].componentsSeparatedByString("=")[2]
                
                print("The code = \(code)")
                
                requestForAccessToken(code)
            
            }
        
        }
        
        print("返回的连接: \(url)")
        
        return true
    }
    
    func requestForAccessToken(authorizationCode: String) {
        
        let grantType = "authorization_code"
        
        let redirectURL = "https://api.weibo.com/auth2/default.html"
        
        var postParms = "\(accessTokenEndPoint)?"
        
         postParms += "client_id=\(weiboKey)&"
        
        postParms += "client_secret=\(weiboSecret)&"
        
        postParms += "grant_type=\(grantType)&"
        
        postParms += "redirect_uri=\(redirectURL)&"
        
        postParms += "code=\(authorizationCode)"
        
        let bodyStr = "type=focus-c"
        
        let postData = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
        
        let postRequest = NSMutableURLRequest(URL: NSURL(string: postParms)!)
        
        postRequest.HTTPMethod = "POST"
        
        postRequest.HTTPBody = postData
        
        //postRequest.addValue("aplication/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        print(postParms)
        
        //https://api.weibo.com/oauth2/access_token?client_id=1227520346&client_scrent=097fecf20a2cca6495bd35d2d0c2d7dd&grant_type=authorization_code&redirect_uri=https://api.weibo.com/auth2/default.html&code=8434e39abc11db25039318bbd64e3951
        
        //https://api.weibo.com/oauth2/access_token?client_id=2909579077&client_secret=90184f4606fd04f449131ea4fbdb74c4&grant_type=authorization_code&redirect_uri=http://www.baidu.com&code=a6146547f981199c07348837b0629d5d
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(postRequest) { (data, response, error) -> Void in
            
            let statueCode = (response as! NSHTTPURLResponse).statusCode
            
            print("statueCode = \(statueCode)")
            
            if statueCode == 200 {
                
                do {
                    
                    let dataDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                    
                    let accessToken = dataDictionary["access_token"] as! String
                    
                    print("accessToken = \(accessToken)")
                    
                    NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "weiboAccessToken")
                    
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] () -> Void in
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    
                    
                    }
                
                } catch {
                    
                    print("error \(error)")
                
                }
            
            
            }
        
        }
        
        task.resume()
    
    
    }
    
    
    func startAuthorization() {
        
        let responseType = "code"
        
        let redirectURL = "https://api.weibo.com/auth2/default.html"
        let state = "authorize"
        
        //https://api.weibo.com/oauth2/authorize?client_id=2909579077&redirect_uri=http://www.baidu.com&response_type=code&display=mobile&state=authorize
        
        //https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
        
        let display = "mobile"
        
        var authorizationURL = "\(authorizationEndPoint)?"
        
        authorizationURL += "client_id=\(weiboKey)&"
        
        authorizationURL += "redirect_uri=\(redirectURL)&"
        
        authorizationURL += "response_type=\(responseType)&"
        
        authorizationURL += "display=\(display)&"
        
        authorizationURL += "state=\(state)"
        
        let request = NSURLRequest(URL: NSURL(string: authorizationURL)!)
        
        print(authorizationURL)
        
        webView.loadRequest(request)
        
        
    
    }
    
    
}
