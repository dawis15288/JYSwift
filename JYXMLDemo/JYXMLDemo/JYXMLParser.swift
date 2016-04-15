//
//  JYXMLParser.swift
//  JYXMLDemo
//
//  Created by atom on 16/4/13.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit


@objc protocol XMLParserDelegate {
    
    func parsingWasFinished()

}

class JYXMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    
    var delegate: XMLParserDelegate?
    
    //
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        
        let parser = NSXMLParser(contentsOfURL: rssURL)
        
        parser?.delegate = self
        
        parser?.parse()
    
    }

}

extension JYXMLParser {
    
    /// <title>Understanding Self Sizing Cells and Dynamic Type in iOS 8</title>
    ///<link>http://feedproxy.google.com/~r/appcoda/~3/NBLtJtdCP7Q/</link>
    ///<comments>http://www.appcoda.com/self-sizing-cells/#comments</comments>
    ///<pubDate>Thu, 04 Sep 2014 17:09:31 +0000</pubDate>
    ///<dc:creator><![CDATA[Simon Ng]]></dc:creator>
   /// <categ

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if( currentElement == "title" && currentElement != "Appcoda") || currentElement == "link" || currentElement == "pubDate" {
        
            foundCharacters += string
        
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link" {
            
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
                
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
            
            if elementName == "pubDate"  {
                
                arrParsedData.append(currentDataDictionary)
            
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        
    }
}
