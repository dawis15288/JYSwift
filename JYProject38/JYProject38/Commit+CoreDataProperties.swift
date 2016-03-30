//
//  Commit+CoreDataProperties.swift
//  JYProject38
//
//  Created by atom on 16/2/14.
//  Copyright © 2016年 cyin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Commit {

    @NSManaged var date: NSDate
    @NSManaged var message: String
    @NSManaged var sha: String
    @NSManaged var url: String

}
