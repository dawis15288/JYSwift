//
//  JYStockQuoteItem.swift
//  JYPageViewControllerProject
//
//  Created by atom on 16/2/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

class StockQuoteItem: ResponseJSONObjectSerializable{
    
    let symbol: String?
    
    let ask: String?
    
    let yearHigh: String?
    
    let yearLow: String?
    
    //https://query.yahooapis.com/v1/public/yql?q=*encoded query*
    
    required init?(json: JSON) {
        
        self.symbol = json["symbol"].string
        
        self.ask = json["Ask"].string
        
        self.yearHigh = json["Yearhight"].string
        
        self.yearLow = json["YearLow"].string
    
    }
    
    class func getFeeItems(symbol: Array<String>, completionHandler:([StockQuoteItem]?, NSError?) -> Void ) {
        
        Alamofire.request(.GET, self.endpointForFeed(symbol)).responseArrayPath(["query", "results", "quote"], completionHandler: { (request, response, stocks: [StockQuoteItem]?, error) -> Void in
            
            completionHandler(stocks, error)
        
        })
        
    
    }
    
    class func endpointForFeed(symbols: Array<String>) -> String {
        
        //用给定的字符串把数组元素穿起来，组成一个新的字符串！
        
        let symboleString: String = symbols.joinWithSeparator("\", \"")
        
        let query = "select * from yahoo.finance.quotes where symbol in (\"\(symboleString) \")&format=json&env=http://datatables.org/alltables.env"
        let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        let endpoint = "https://query.yahooapis.com/v1/public/yql?q=" + encodedQuery!
        return endpoint
    }
    
}