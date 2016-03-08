//
//  ViewController.swift
//  JYZhihuNewsProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var NewsListArray: [JSON] = []
    
    var loaderView: JYCycleLoaderView!
    
    @IBOutlet weak var tableView: UITableView!
    let urlString: String = "http://news-at.zhihu.com/api/4/news/latest"
    
    var cell: NewsListCell!
    
    var refreshController: UIRefreshControl!
    
    var custom: UIView!
    
    var isAnimating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadCustomRefreshContents()
        
        tableView.addSubview(refreshController)
        
        refreshController.beginRefreshing()
        
        let nib = UINib(nibName: "NewsListCell", bundle: NSBundle.mainBundle())
        
        tableView.registerNib(nib, forCellReuseIdentifier: "newsListCell")
        
        fetchData()
        
        
    }
    
    func fetchData() {
        if let url = NSURL(string: urlString) {
            
            let request = NSURLRequest(URL: url)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self ] (data, response, error) -> Void in
                
                if response != nil {
                    
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                        
                        if let data = data {
                            
                            let newsData = JSON(data: data)
                            
                            if let newsArray = newsData["stories"].array {
                            
                                self.NewsListArray = newsArray
                            }
                            
                            print(self.NewsListArray.count)
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                    
                }
                
            })
            
            task.resume()
            
        }
    
    }
    
    func loadCustomRefreshContents() {
        
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        
        refreshController = UIRefreshControl()
        
        custom = refreshContents[0] as! UIView
        
        loaderView = JYCycleLoaderView(frame: CGRect(x: 196, y: 22, width: 20, height: 20))
        
        custom.addSubview(loaderView)
        
        refreshController.addSubview(custom)
    
    }
    
    // MARK: --scrollView的delegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if refreshController.refreshing {
            
            //print("refreshController.refreshing")
            
            if !isAnimating {
                
               loaderView.startAnimation()
            
            }
        
        }
    }
    
    
    // MARK: --tableView的datasource和delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.NewsListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCellWithIdentifier("newsListCell", forIndexPath: indexPath) as! NewsListCell
        
        self.cell.titleLabel.text = self.NewsListArray[indexPath.row]["title"].string!
        
        let imageURL = self.NewsListArray[indexPath.row]["images"][0].string!
        
        if let imagesURL = NSURL(string: imageURL) {
            
            //self.loaderView.startAnimation()
            
            let request = NSURLRequest(URL: imagesURL)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self] (data, response, error) -> Void in
                
                    if response != nil {
                        
                        if ( response as! NSHTTPURLResponse).statusCode == 200 {
                            
                            if let data = data {
                                
                               
                                //self.loaderView.stopAnimation()
                                self.cell.newsImageView.image = UIImage(data: data)
                            
                            }
                        
                        }
                
                    }
                
                })
            
            task.resume()
        
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

