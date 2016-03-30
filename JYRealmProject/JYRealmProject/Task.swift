//
//  Task.swift
//  JYRealmProject
//
//  Created by atom on 16/2/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var name = ""
    
    dynamic var createdAt = NSDate()
    
    dynamic var notes = ""
    
    dynamic var isCompleted = false
    
    //let tasks = List<Task>()
    
    
}
