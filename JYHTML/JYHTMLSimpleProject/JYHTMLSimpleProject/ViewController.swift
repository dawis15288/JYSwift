//
//  ViewController.swift
//  JYHTMLSimpleProject
//
//  Created by atom on 16/2/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

import HTMLReader

class ViewController: UIViewController {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var cycleLoadViw: JYCycleLoaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView: UIImageView!
    
    let url = "http://www.javlibrary.com/cn/?v=javlildbs4"
    
    var titles: Array<String> = []
    
    var contents: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cycleLoadViw.startAnimation()
        
        fetchCharts()
    }
    
    func fetchCharts() {
        
        print("fetchCharts()")
        
        Alamofire.request(.GET, url).responseString(completionHandler: { (responseStrings) -> Void in
            
            guard responseStrings.result.error == nil else {
                
                return
            
            }
            
            guard let htmlString = responseStrings.result.value else { return }
            
            let doc = HTMLDocument(string: htmlString)
            
            let tables = doc.nodesMatchingSelector("tbody")
            
            
            for table in tables {
                
                if let tableEelement = table as? HTMLElement {
                    
                    print(tableEelement)
                    
                    for row in tableEelement.children {
                        
                        if let rowElement = row as? HTMLElement {
                            
                            //print(rowElement.nodesMatchingSelector("td"))
                            
                            
                            for i in 0 ..< rowElement.nodesMatchingSelector("td").count {
                                
                                if let td = rowElement.nodesMatchingSelector("td")[i] as? HTMLElement {
                                    
                                    //print(td.objectForKeyedSubscript("class"))
                                    
                                    if let className = td.objectForKeyedSubscript("class") as? String {
                                        
                                        if className == "header" {
                                            
                                            let text = td.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString("\n", withString: "")
                                            
                                            self.titles.append(text)
                                        
                                        } else if className == "text" {
                                            
                                            print(td.textContent)
                                            
                                            self.contents.append(td.textContent)
                                            
                                        
                                        }
                                    
                                    }
                                
                                }
                            
                            }
                            
                            if let firstColumn = rowElement.childAtIndex(0) as? HTMLElement {
                            
                               //print(firstColumn.nodesMatchingSelector("div"))
                                
                                
                                
                                if let urlNode = firstColumn.firstNodeMatchingSelector("div") {
                                    
                                    
                                    
                                    if let urlNode = urlNode.firstNodeMatchingSelector("img") {
                                        
                                        //print(urlNode)
                                        
                                        if let urlString = urlNode.objectForKeyedSubscript("src") {
                                            
                                            //print(urlString)
                                            
                                            if let urlString = urlString as? String {
                                                
                                                if let url = NSURL(string: urlString) {
                                                    
                                                    let request = NSURLRequest(URL: url)
                                                    
                                                    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                                                    
                                                    let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { [unowned self ] (data, response, error) -> Void in
                                                        
                                                        if (response as! NSHTTPURLResponse).statusCode == 200 {
                                                            
                                                            //print(200)
                                                            
                                                            if let data = data {
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                                    
                                                                    self.imageView = UIImageView(image: UIImage(data: data))
                                                                    
                                                                    
                                                                    self.scrollView.addSubview(self.imageView)
                                                                    
                                                                    //1
                                                                    self.scrollView.backgroundColor = UIColor.blackColor()
                                                                    //2
                                                                    self.scrollView.contentSize = self.imageView.bounds.size
                                                                    
                                                                   self.view.addSubview(self.scrollView)
                                                                    
                                                                    //print(self.contents[0])
                                                                    self.tagLabel.text = "番号:\(self.contents[0])"
                                                                    
                                                                })
                                                            
                                                            }
                                                            
                                                            
                                                        
                                                        }
                                                    
                                                    })
                                                    
                                                    task.resume()
                                                
                                                }
                                                
                                                
                                            
                                            }
                                            
                                        
                                        }
                                    
                                    }
                                
                                }
                            }
                        
                        }
                    
                    }
                
                }
            
            }
        
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

