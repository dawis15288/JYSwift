//
//  CoffeeAnnotation.swift
//  JYCoffeeProjct
//
//  Created by atom on 16/2/25.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import MapKit

class CoffeeAnntation: NSObject, MKAnnotation {
    
    
    let title: String?
    
    let subtitle: String?
    
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        
        self.subtitle = subtitle
        
        self.coordinate = coordinate
        
        super.init()
        
    }
    
    
    
}