//
//  InterfaceController.swift
//  JWatchWeatherProject WatchKit Extension
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import WatchKit
import Foundation

import WatchWeatherWatchKit


class InterfaceController: WKInterfaceController {
    @IBOutlet var hightTempratureLabel: WKInterfaceLabel!
    @IBOutlet var lowTempratureLabel: WKInterfaceLabel!

    @IBOutlet var weathrImage: WKInterfaceImage!
    
    static var index = Day.DayBeforeYesterday.rawValue
    
    static var controllers = [Day: InterfaceController]()
    
    static var token: dispatch_once_t = 0
    
    var weathr: Weather? {
        
        didSet {
            
            if let w = weathr {
                
                updateWather(w)
            
            }
        
        }
    
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        guard let day = Day(rawValue: InterfaceController.index) else {
            
            return
        
        }
        
        InterfaceController.controllers[day] = self
        
        InterfaceController.index = InterfaceController.index + 1
        
        if day == .Today {
            
            becomeCurrentPage()
        
        }
        
        dispatch_once(&InterfaceController.token){ () -> Void in
        
            self.request()
        }
        
    }
    
    func request() {
        
        WeatherClient.sharedClient.requstWeather{ [unowned self] (weathers, error) -> Void in
        
            if let weathers = weathers {
                
                for weather in weathers where weather != nil {
                    
                    guard let jyController = InterfaceController.controllers[weather!.day] else { continue }
                    
                    jyController.weathr = weather
                    
                }

            
            } else {
                
                let action = WKAlertAction(title: "Retry", style: .Default, handler: { [unowned self ](action) -> Void in
                    
                    self.request()
                
                })
                
                let errorMessage = (error != nil) ? error!.description : "unkowned error"
                
                self.presentAlertControllerWithTitle("Error", message: errorMessage, preferredStyle: .Alert, actions: [action])
            
            }
        }
    
    }
    
    func updateWather(weather: Weather) {
        
        lowTempratureLabel.setText("\(weather.lowTemperature)")
        
        hightTempratureLabel.setText("\(weather.hightTemperature)")
        
        let imageName: String
        
        switch weather.state {
        
        case .Sunny: imageName = "sunny"
            
        case .Cloudy: imageName = "cloudy"
            
        case .Rain: imageName = "rain"
            
        case .Snow: imageName = "snow"
            
        }
        
        weathrImage.setImageNamed(imageName)
    
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let w = weathr {
        
            updateWather(w)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
