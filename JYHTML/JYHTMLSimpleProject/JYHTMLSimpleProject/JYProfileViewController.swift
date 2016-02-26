//
//  JYProfileViewController.swift
//  JYHTMLSimpleProject
//
//  Created by atom on 16/2/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import HTMLReader

class JYProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    let url = "http://www.javlibrary.com/cn/vl_star.php?s=aydqo"
    
    //let url = "http://www.javlibrary.com/cn/?v=javlildbs4"
    
    var titles: Array<String> = []
    
    var imgURL: Array<String> = []
    
    var jyCell: JYCell!
    
    var row: Int!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchCharts()
        
    }
    
    func fetchCharts() {
        
        //print("fetchCharts")
        
        if let url = NSURL(string: url) {
            
            let request = NSURLRequest(URL: url)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self](data, response, error) -> Void in
                
                    if response != nil {
                        
                        if (response as! NSHTTPURLResponse).statusCode == 200 {
                            
                            if let data = data {
                                
                                let doc = HTMLDocument(data: data, contentTypeHeader: "text/html; charset=UTF-8")
                                
                                let divs = doc.nodesMatchingSelector("div")
                                
                                for div in divs {
                                    
                                    if let div = div as? HTMLElement {
                                        
                                        //print(div.objectForKeyedSubscript("class"))
                                        
                                        if let divClass = div.objectForKeyedSubscript("class") as? String {
                                            
                                            //print(divClass)
                                            
                                            if "video" == divClass {
                                            
                                                if let a = div.childAtIndex(0) as? HTMLElement {
                                            
                                                    //print(a.objectForKeyedSubscript("title"))
                                                    if let title = a.objectForKeyedSubscript("title") as? String {
                                                        
                                                         let onTitle = title.componentsSeparatedByString(" ")
                                                        
                                                        self.titles.append(onTitle[0])
                                                    
                                                    }
                                                    
                                                    //print(a.childAtIndex(1))
                                                    
                                                    if let img = a.childAtIndex(1) as? HTMLElement {
                                                        
                                                        if let imgURL = img.objectForKeyedSubscript("src") as? String {
                                                            
                                                            print(imgURL)
                                                            
                                                            self.imgURL.append(imgURL)
                                                        
                                                        }
                                                        
                                                    
                                                    }
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                        
                                                        self.collectionView.reloadData()
                                                    
                                                    })
                                            
                                                }
                                                
                                                
                                            
                                            }
                                        
                                        }
                                        
                                        //let divClass = div.objectForKeyedSubscript("class") as! String
                                        
                                        
                                    
                                    }
                                
                                }
                            
                            }
                        
                        }
                
                    }
                
                
                })
            
            task.resume()
        
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionView
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListCell", forIndexPath: indexPath) as! JYCell
        
        jyCell = cell
        
        row = indexPath.row
        
        if let imageURL = NSURL(string: imgURL[indexPath.row]) {
            
            let request = NSURLRequest(URL: imageURL)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [ unowned self ] (data, response, error) -> Void in
                
                if response != nil {
                    
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                        
                        if let data = data {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.jyCell.imageView.image = UIImage(data: data)
                                
                                self.jyCell.titleLabel.text = self.titles[self.row]
                                
                            })
                            
                        }
                    }
                
                }
                
            })
            
            task.resume()
            
        }
        
        //cell.imageView.image = UIImage(named: "")
        
        //cell.titleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
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
