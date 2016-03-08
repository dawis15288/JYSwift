//
//  Weather.swift
//  JWatchWeatherProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


public struct Weather {
    
    public enum State: Int {
        
        case Sunny, Cloudy, Rain, Snow
    }
    
    public let state: State
    
    public let hightTemperature: Int
    
    public let lowTemperature: Int
    
    public let day: Day
    
    public init?(json: [String: AnyObject]) {
        
        print("\(json)")
        
        guard let stateNumber = json["state"] as? Int ,
            
            state = State(rawValue: stateNumber),
            
            hightTemperature = json["high_temp"] as? Int,
            
            lowTemperature = json["low_temp"] as? Int,
            
            dayNumber = json["day"] as? Int,
            
            day = Day(rawValue: dayNumber) else {
                
                return nil
                
        }
        
        self.state = state
        
        self.hightTemperature = hightTemperature
        
        self.lowTemperature = lowTemperature
        
        self.day = day
        
    }
    
}

extension Weather {
    
    static func parseWeathrResult(dictionary: [String: AnyObject]) -> [Weather?]? {
        
        
        
        if let weathers = dictionary["weathers"] as? [[String: AnyObject]] {
            
            print("parseWeathrResult\(weathers)")
            
            return weathers.map { Weather(json: $0)}
            
        } else {
            
            return nil
            
        }
        
    }
    
}
