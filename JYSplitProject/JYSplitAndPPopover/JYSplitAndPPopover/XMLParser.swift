//
//  XMLParser.swift
//  JYSplitAndPPopover
//
//  Created by atom on 16/1/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate {
    
    func parsingWasFinished()

}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParserData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    
    var delegate: XMLParserDelegate?
    
    func startParsingWithContentsfURL(rssURL: NSURL) {
        
        let parser = NSXMLParser(contentsOfURL: rssURL)
        
        parser!.delegate = self
        
        parser!.parse()
    
    }
    
   
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if ( currentElement == "title" && currentElement != "Appcoda") || currentElement == "link" || currentElement == "pubDate" {
        
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
            
            if currentElement == "pubDate" {
                
                arrParserData.append(currentDataDictionary)
            
            }
        
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        print(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        
        print(validationError.description)
    }
    
    /*
    
    <item>
    <title>Understanding Self Sizing Cells and Dynamic Type in iOS 8</title>
    <link>http://feedproxy.google.com/~r/appcoda/~3/NBLtJtdCP7Q/</link>
    <comments>http://www.appcoda.com/self-sizing-cells/#comments</comments>
    <pubDate>Thu, 04 Sep 2014 17:09:31 +0000</pubDate>
    <dc:creator><![CDATA[Simon Ng]]></dc:creator>
    <category><![CDATA[Beginner]]></category>
    <category><![CDATA[Course]]></category>
    <category><![CDATA[Swift]]></category>
    <category><![CDATA[Tutorials]]></category>
    <category><![CDATA[dynamic type]]></category>
    <category><![CDATA[self sizing cell]]></category>
    <category><![CDATA[swift]]></category>
    <category><![CDATA[UITableView]]></category>
    
    <guid isPermaLink="false">http://www.appcoda.com/?p=4013</guid>
    
    <wfw:commentRss>http://www.appcoda.com/self-sizing-cells/feed/</wfw:commentRss>
    <slash:comments>9</slash:comments>
    <description>In iOS 8, Apple introduces a new feature for UITableView known as Self Sizing Cells. To me, this is seriously one of the most exciting features for the new SDK. Prior to iOS 8, if you want to display dynamic content in table view with variable height, you would need to calculate the row height [&amp;amp;#8230;]
    
    This article, Understanding Self Sizing Cells and Dynamic Type in iOS 8, was originally published at AppCoda.&amp;lt;br/&amp;gt;
    &amp;lt;br/&amp;gt;
    [[ This is a content summary only. Visit my website for full links, other content,
    
    */

}
