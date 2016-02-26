//
//  DataController.swift
//  JYHTMLProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

import HTMLReader



let URLString1 = "http://ocsdata.ncd.noaa.gov/BookletChart/AtlanticCoastBookletCharts.htm"

let URLString = "http://www.charts.noaa.gov/OnLineViewer/AtlanticCoastViewerTable.shtml"


class DataController {
    
    var charts: [Chart]?
    
    private func parseHTMLRow(rowElement: HTMLElement) -> Chart? {
        
        print("dataController ====== isChartsTable")
        
        var url: NSURL?
        
        var number: Int?
        
        var scale: Int?
        
        var title: String?
        
        if let firstColumn = rowElement.childAtIndex(1) as? HTMLElement {
            
            if let urlNode = firstColumn.firstNodeMatchingSelector("a") {
                
                if let urlString = urlNode.objectForKeyedSubscript("href") as? String {
                    
                    url = NSURL(string: urlString)!
                
                }
                
                let textNumber = firstColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                    number = Int(textNumber)
            
            }
        
        }
        
        if (url == nil || number == nil) {
            
            return nil
        
        }
        
        if let secondColumn = rowElement.childAtIndex(3) as? HTMLElement {
            
            let text = secondColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString(",", withString: "")
            
            scale = Int(text)
            
        
        }
        
        if let thirdColumn = rowElement.childAtIndex(5) as? HTMLElement {
            
            title = thirdColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString("  ", withString: "")
        
        }
        
        if let title = title, url = url, number = number, scale = scale {
            
            print("dataController ====== isChartsTable \(title)\n\(url)\n\(number)\n\(scale)")
            
            return Chart(title: title, url: url, number: number, scale: scale)
        
        }
        
        return nil
    
    }
    
    private func isChartsTable(tableElement: HTMLElement) -> Bool {
        
        print("dataController ====== isChartsTable")
        
        if tableElement.children.count > 0 {
            
            let firstChild = tableElement.childAtIndex(0)
            
            let lowerCaseContent = firstChild.textContent.lowercaseString
            
            if lowerCaseContent.containsString("number") && lowerCaseContent.containsString("scale") && lowerCaseContent.containsString("title") {
                
                return true
            
            }
        
        }
        
        return false
    
    }
    
    func fetchCharts(completionHandler: (NSError?) -> Void) {
        
        print("dataController ====== fetchCharts")
        
        Alamofire.request(.GET, URLString)
        
            .responseString { responseString in
                
               // print(responseString)
                
                guard responseString.result.error == nil else {
                    
                    completionHandler(responseString.result.error)
                    
                    return
                
                }
                
                guard let htmlAsString = responseString.result.value else {
                    
                    let error = Error.errorWithCode(.StringSerializationFailed, failureReason: "Could not get HTML as String")
                    
                    completionHandler(error)
                    
                    return
                
                }
                
                let doc = HTMLDocument(string: htmlAsString)
                
                let tables = doc.nodesMatchingSelector("tbody")
                
                var chartsTable: HTMLElement?
                
                for table in tables {
                
                    if let tableElement = table as? HTMLElement {
                    
                        if self.isChartsTable(tableElement) {
                            
                            chartsTable = tableElement
                            
                            break
                        
                        }
                    }
                }
                
                guard let tableContents = chartsTable else {
                    
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: "Could not find charts table in HTML document")
                    
                    completionHandler(error)
                    
                    return
                
                }
                
                self.charts = []
                
                for row in tableContents.children {
                    
                    if let rowElement = row as? HTMLElement {
                        
                        if let newChart = self.parseHTMLRow(rowElement) {
                            
                            self.charts?.append(newChart)
                        
                        }
                    
                    }
                
                }
                
                completionHandler(nil)
        
        }
    
    }
    
    func isChartDownloaded(chart: Chart) -> Bool {
        
        if let path = chart.urlInDocumentsDirectory?.path {
            
            let filemanager = NSFileManager.defaultManager()
            
            return filemanager.fileExistsAtPath(path)
            
        
        }
        
        return false
    
    }
    
    func downloadChart(chart: Chart, completionHandler: (Double?, NSError?) -> Void ) {
        
        guard isChartDownloaded(chart) == false else {
            
            print("file is exected!")
            
            completionHandler(1.0, nil)
            
            return
        
        }
        
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        
        Alamofire.download(.GET, chart.url, destination: destination).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                let progress = Double(totalBytesRead) / Double(totalBytesExpectedToRead)
                
                completionHandler(progress, nil)
            
            }
        
        
            }.responseString { response in
                
                print(response.result.error)
                
                completionHandler(nil, response.result.error)
        
        }
        
    }
    
}