//
//  TodoClass.swift
//  JYTodo
//
//  Created by atom on 16/4/15.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

class Todo  {
    
    var title: String?
    
    var id: Int?
    
    var userid: Int?
    
    var completed: Int?
    
    required init?(title: String?, id: Int?, userid: Int?, completed: Int?){
        
        self.title = title
        
        self.id = id
        
        self.userid = userid
        
        self.completed = completed
    
    }
    
    required init?(json: [String: AnyObject]){
        
        self.title = json["title"] as? String
        
        self.id = json["id"] as? Int
        
        self.userid = json["userId"] as? Int
        
        self.completed = json["completed"] as? Int
        
    }
    
    class func endpointForID(id: Int) -> String {
        
        return "http://jsonplaceholder.typicode.com/todos/\(id)"
        
    }
    
    class func endpointForTodos() -> String {
        
        return "http://jsonplaceholder.typicode.com/todos/"
    
    }
    
    class func todoByID(id: Int, completionHandler: (Todo?, NSError?) -> Void) {
        
        let endpoint = Todo.endpointForID(id)
        
        guard let url = NSURL(string: endpoint) else {
        
            print("Error: cannot create URL")
            
            let error = NSError(domain: "TodoClass", code: 1, userInfo: [NSLocalizedDescriptionKey: "cannot create URL"])
            
            completionHandler(nil, error)
            
            return
            
        }
        
        let urlrequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlrequest) { (data, response, error) in
            
            guard let responseData = data else {
                
                print("Error: did not receive data")
                
                completionHandler(nil, error)
                
                return
            
            }
            
            guard error == nil else {
                
                print("error calling GET on /todos/1")
                
                print(error)
                
                completionHandler(nil, error)
                
                return
            
            }
            
            do {
                
                if let todoJSON = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject] {
                    
                    if let todo = Todo(json: todoJSON) {
                    
                        completionHandler(todo, nil)
                        
                        
                    } else {
                        
                        let error = NSError(domain: "TodoClass", code: 3, userInfo: [NSLocalizedDescriptionKey: "Couldn't create a todo object from the JSON"])
                        
                        completionHandler(nil, error)
                    
                    }
                
                }
            
            } catch {
                
                print("error trying to convert data to JSON")
                
                let error = NSError(domain: "TodoClass", code: 2, userInfo: [NSLocalizedDescriptionKey: "error trying to convert data to JSON"])
                
                completionHandler(nil, error)
                
                return
            
            }
        }
        
        task.resume()
    
    }
    
    func toJSON() -> [String: AnyObject] {
        
        var json = [String: AnyObject]()
        
        if let title = title {
            
            json["title"] = title
            
        }
        
        if let id = id {
            
            json["id"] = id
            
        }
        
        if let userId = userid {
            
            json["userId"] = userId
            
        }
        
        if let completed = completed {
            
            json["completed"] = completed
            
        }
        
        return json
    
    }
    
    func saveNoAlamofire(completionHandler: (Todo?, NSError?) -> Void) {
    
        let todosEndpoint = Todo.endpointForTodos()
        
        guard let todosURL = NSURL(string: todosEndpoint) else {
        
            let error = NSError(domain: "TodoClass", code: 4, userInfo: [NSLocalizedDescriptionKey: "Error: cannot create URL"])
            
            completionHandler(nil, error)
            
            return
        
        }
        
        let todosUrlRequest = NSMutableURLRequest(URL: todosURL)
        
        todosUrlRequest.HTTPMethod = "POST"
        
        let TodoAsJSON = self.toJSON()
        
        let jsonTodo: NSData
            
         do {
        
            jsonTodo = try NSJSONSerialization.dataWithJSONObject(TodoAsJSON, options: NSJSONWritingOptions(rawValue: 0))
            
            todosUrlRequest.HTTPBody = jsonTodo
            
        } catch {
        
            let error = NSError(domain: "TodoClass", code: 5, userInfo: [NSLocalizedDescriptionKey: "Error: cannot create JSON from todo"])
            completionHandler(nil, error)
            return
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(todosUrlRequest) { (data, response, error) in
            
            guard let responseData = data else {
                
                print("Error: did not receive data")
                
                return
            
            }
            
            guard error == nil else {
            
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            
            do {
            
                if let todoJSON = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject] {
                    
                    if let todo = Todo(json: todoJSON) {
                        
                        completionHandler(todo, nil)
                    
                    } else {
                        
                        let error = NSError(domain: "TodoClass", code: 3, userInfo: [NSLocalizedDescriptionKey: "Couldn't create a todo object from the JSON"])
                        
                        completionHandler(nil, error)
                    
                    }
                
                }
            } catch {
                
                print("error parsing response from POST on /todos")
                return
            
            }
        }
        
        task.resume()
    
    }
    
    
}
