//
//  APIController.swift
//  JYNASAProject
//
//  Created by atom on 16/2/17.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import UIKit


class APIController {
    
    let API_KEY = "Af09xrLUlKOkGE1X0Ke4K36JgHsyv5OKf8bPbEx7"
    
    let urlComponents = NSURLComponents()
    
    init() {
        
        urlComponents.scheme = "https"
        
        urlComponents.host = "api.nasa.gov"
        
        
    
    }
    
    func dateToString(date: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print("\(dateFormatter.stringFromDate(date))")
        
        return dateFormatter.stringFromDate(date)
    
    }
    
    func createURLWithString(date: NSDate) -> NSURL? {
        
        var urlString: String = "https://api.nasa.gov/planetary/apod"
        
        urlString = urlString.stringByAppendingString("?date=" + "\(dateToString(date))")
        
        urlString = urlString.stringByAppendingString("&concept_tags=false")
        
        urlString = urlString.stringByAppendingString("&hd=false")
        
        urlString = urlString.stringByAppendingString("&api_key=" + "\(API_KEY)")
        
        return NSURL(string: urlString)
    
    }
    
    func createURLWithComponents(date: NSDate) -> NSURL? {
        
        urlComponents.path = "/planetary/earth/imagery"
        
        let dateQuery = NSURLQueryItem(name: "date", value: "\(dateToString(date))")
        
        let conceptQuery = NSURLQueryItem(name: "concept_tags", value: "false")
        
        //let hdQuery = NSURLQueryItem(name: "hd", value: "false")
        
        let hdQuery = NSURLQueryItem(name: "hd", value: "true")
        
        let apiQuery = NSURLQueryItem(name: "api_key", value: "\(API_KEY)")
        
        urlComponents.queryItems = [dateQuery, conceptQuery, hdQuery, apiQuery]
        
        return urlComponents.URL
    
    }
    
    func getAPOD(date: NSDate) {
        
       guard let url = createURLWithComponents(date) else {
            
            print("invalid URL")
            
            return
        
        }
        
        /*guard let url = createURLWithString(date) else {
        
            print("invalid URL")
            
            return
            
        }*/
        
        print("getAPOD----> \(url)")
        
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            
            do {
                
                guard error == nil else {
                    
                    print(error!)
                    
                    return
                
                }
                
                if let data = data, let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] {
                    
                    print(json)
                    
                    if let imageURLString = json["url"] as? String {
                        
                        if let url = NSURL(string: imageURLString) {
                            
                            UIApplication.sharedApplication().openURL(url)
                            
                            return
                        
                        }
                    
                    }
                
                }
            
            } catch _ {
                
                print("error")
            
            }
        
        
        })
        
        task.resume()
    
    }

}