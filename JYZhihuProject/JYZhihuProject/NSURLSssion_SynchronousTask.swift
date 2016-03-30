//
//  NSURLSssion_SynchronousTask.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


extension NSURLSession {

    func sendSynchronousDataTaskWithURL(url: NSURL) throws -> NSData? {
        
        var response: NSURLResponse? = nil
        
        return try self.sendSynchronousDataTaskWithURL(url, rturningResponse: &response)
    
    }
    
    func sendSynchronousDataTaskWithURL(url: NSURL, inout rturningResponse response: NSURLResponse?) throws -> NSData? {
        
        let smaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        
        var data: NSData? = nil
        
        var error: NSError? = nil
        
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (taskData, taskResponse, taskError) -> Void in
            
            data = taskData
            
            if let _response = taskResponse {
                
                response = _response
            
            
            }
            
            error = taskError
            
            dispatch_semaphore_signal(smaphore)
        
        
        }).resume()
        
        dispatch_semaphore_wait(smaphore, DISPATCH_TIME_FOREVER)
        
        if let _error = error {
            
            throw AppException.Other(_error.description)
        
        }
        
        return data
    
    }

}