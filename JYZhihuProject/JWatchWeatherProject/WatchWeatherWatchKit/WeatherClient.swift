//
//  WeatherClient.swift
//  JWatchWeatherProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


public let WatchWeatherkitErrorDomain = "com.jy.WatchWatherKit.error"

public struct WatchWeathrKitError {
    
    public static let CorruptedJSON = 1000
    
}

public struct WeatherClient {
    
    public static let sharedClient = WeatherClient()
    
    let session = NSURLSession.sharedSession()
    
    public func requstWeather(handler: ((weather: [Weather?]?, error: NSError?) -> Void)?) {
        
        guard let url = NSURL(string: "https://raw.githubusercontent.com/onevcat/WatchWeather/master/Data/data.json") else {
            
            handler?(weather: nil, error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
            
            return
            
        }
        
        let task = session.dataTaskWithURL(url, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                
                handler?(weather: nil, error: error)
            } else {
                
                do {
                    
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    
                    
                    if let dictionary = object as? [String: AnyObject] {
                        
                        //print("dictionary = object as? [String: AnyObject] --> \(Weather.parseWeathrResult(dictionary))\n\n")
                        
                        handler?(weather: Weather.parseWeathrResult(dictionary), error: nil)
                        
                        
                        
                    }
                    
                } catch _ {
                    
                    handler?(weather: nil, error: NSError(domain: WatchWeatherkitErrorDomain, code: WatchWeathrKitError.CorruptedJSON, userInfo: nil))
                    
                }
                
            }
            
        })
        
        task.resume()
        
        
    }
}
