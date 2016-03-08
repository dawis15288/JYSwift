//
//  OAuthViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SVProgressHUD

class OAuthViewController: UIViewController {
    
    private let WB_Client_ID = "1227520346"
    
    private let WB_REDIRECT_URI = ""
    
    private let WB_REDIRECT_URL = ""
    
    let weiboKey = "1227520346"
    
    let weiboSecret = "097fecf20a2cca6495bd35d2d0c2d7dd"
    
    //https://api.weibo.com/oauth2/authorize
    
    let authorizationEndPoint = "https://open.weibo.cn/oauth2/authorize"
    
    let accessTokenEndPoint = "https://api.weibo.com/oauth2/access_token"
    
    private lazy var webView: UIWebView = {
    
        let wv = UIWebView()
        
        wv.delegate = self
        
        return wv
    
    }()
    
    
    
    override func loadView() {
        
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "oauth"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "closee")
        
        //loadOAuthPage()
        
        startAuthorization()
    }
    
    private func startAuthorization() {
        
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
    
    private func loadOAuthPage() {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_Client_ID)&redirect_uri=\(WB_REDIRECT_URI)"
        
        let url = NSURL(string: urlString)
        
        let resquest = NSURLRequest(URL: url!)
        
        webView.loadRequest(resquest)
    }
    
    func closee() {
        
        dismissViewControllerAnimated(true, completion: nil)
    
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

extension OAuthViewController: UIWebViewDelegate {
        
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
                    
                    let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                    
                    let account = UserAccount(dict: dataDictionary as! [String: AnyObject])
                    
                    account.saveAccount()
                    
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] () -> Void in
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        
                    }
                    
                } catch _ {
                    
                    print("error \(error)")
                    
                }
                
                
            }
            
        }
        
        task.resume()
        
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        SVProgressHUD.showInfoWithStatus("页面加载中。。。", maskType: .Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        SVProgressHUD.dismiss()
    }

}
