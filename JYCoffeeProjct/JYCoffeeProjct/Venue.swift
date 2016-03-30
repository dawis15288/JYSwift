//
//  Venue.swift
//  JYCoffeeProjct
//
//  Created by atom on 16/2/25.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import RealmSwift

import MapKit

class Venue: Object {
    
    dynamic var id: String = ""
    
    dynamic var name: String = ""
    
    dynamic var latitude: Float = 0
    
    dynamic var longitude: Float = 0
    
    dynamic var address: String = ""
    
    var coorrdinte: CLLocation {
        
        return CLLocation(latitude: Double(latitude), longitude: Double(longitude))
    
    }
    
    override static func primaryKey() -> String? {
    
        return "id"
    
    }
    
}