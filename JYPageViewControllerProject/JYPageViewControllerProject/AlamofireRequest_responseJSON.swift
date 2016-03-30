//
//  AlamofireRequest_responseJSON.swift
//  JYPageViewControllerProject
//
//  Created by atom on 16/2/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

public protocol ResponseJSONObjectSerializable {
    
    init?(json: JSON)

}


extension Alamofire.Request {
    
    public func responseArrayPath<T: ResponseJSONObjectSerializable>(pathToArray: [String]?, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void ) -> Self {
        
        var objects: [T] = []
        
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            
            if let responseData = data {
            
                var jsonError: NSError?
                
                do {
                    
                    let jsonData: AnyObject? = try NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableContainers)
                    
                    if jsonData == nil || jsonError != nil {
                        
                        return (nil, jsonError!)
                    
                    }
                    
                    if let jsonData  = jsonData {
                        
                        let json = JSON(jsonData)
                        
                        var currentJSON = json
                        
                        if let path = pathToArray {
                            
                            for pathComponent in path {
                                
                                currentJSON = currentJSON[pathComponent]
                                
                            }
                            
                        }
                        
                        
                        
                        for (index, item) in currentJSON {
                            
                            if let object = T(json: item) {
                                
                                objects.append(object)
                                
                            }
                            
                        }
                    
                    }
                    
                    
                    
                    
                
                } catch _ {
                
                
                }
                
                return (objects, nil)
                
            }
            
             return (nil, nil)
        
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    
    }

}