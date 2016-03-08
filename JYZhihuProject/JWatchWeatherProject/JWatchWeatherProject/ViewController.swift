//
//  ViewController.swift
//  JWatchWeatherProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import WatchWeatherKit

class ViewController: UIPageViewController {
    
    var data = [Day: Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataSource = self
        
        let vc = UIViewController()
        
        vc.view.backgroundColor = UIColor.whiteColor()
        
        setViewControllers([vc], direction: .Forward, animated: true, completion: nil)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
       WeatherClient.sharedClient.requstWeather{ (weather, error) -> Void in
            
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
                //print("if error == nil && weather != nil \(weather)\n\n")
            
            if error == nil && weather != nil {
            
                for w in weather! where w != nil {
                    
                    print(w?.hightTemperature)
                    
                    if let w = w {
                        
                        print(w.hightTemperature)
                        
                       self.data[w.day] = w
                    }
                    
                    
                
                }
                
                
                //dispatch_async(dispatch_get_main_queue(), { [ unowned self ] () -> Void in
                
                let vc = self.weathrViewControllerForDay(.Today)
                
                
                self.setViewControllers([vc], direction: .Forward, animated: true, completion: nil)
                
                //})
                
                
            } else {
            
                //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                    let alert = UIAlertController(title: "Error", message: error?.description ?? "unknown Error", preferredStyle: .Alert)
                    
                    alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                //})
                
            }
        
        }
    }
    
    func weathrViewControllerForDay(day: Day) -> UIViewController {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as! WeathrViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        vc.weather = data[day]!
        
        return nav
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let nav = viewController as? UINavigationController,
            
                  viewController = nav.viewControllers.first as? WeathrViewController,
            
                  day = viewController.weather?.day else {
        
            return nil
            
        }
        
        if day == .DayBeforeYesterday {
            
            return nil
        }
        
        guard let earlierDay = Day(rawValue: day.rawValue - 1 ) else { return nil }
        
        return self.weathrViewControllerForDay(earlierDay)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard  let nav = viewController as? UINavigationController,
        
                   viewController = nav.viewControllers.first as? WeathrViewController,
        
            day = viewController.weather?.day else {
                
                return nil
        
        }
        
        if day == .DayAfterTommorrow {
        
            return nil
            
        }
        
        guard let laterDay = Day(rawValue: day.rawValue + 1) else { return nil }
        
        return weathrViewControllerForDay(laterDay)
        
    }
    
}

