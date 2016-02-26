//
//  XMLParser.swift
//  JYSplitProject
//
//  Created by atom on 16/2/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate {
    
    func parsingWasFinished()

}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentEement = ""
    
    var foundCharacters = ""
    
    var delegate: XMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
    
        let parser = NSXMLParser(contentsOfURL: rssURL)
        
        parser?.delegate = self
        
        parser?.parse()
    
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentEement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if (currentEement == "title" && currentEement != "Appcoda") || currentEement == "link" || currentEement == "pubDate" {
            
            print("\(currentEement)")
            
            foundCharacters += string
        
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if !foundCharacters.isEmpty {
            
            if elementName == "link" {
                
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
                
                print(foundCharacters)
            
            }
            
            currentDataDictionary[currentEement] = foundCharacters
            
            foundCharacters = ""
            
            if currentEement == "pubDate" {
                
                arrParsedData.append(currentDataDictionary)
            
            }
        
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        delegate?.parsingWasFinished()
        
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        print("\(parseError.description)")
        
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        
        print("\(validationError.description)")
        
    }

}
