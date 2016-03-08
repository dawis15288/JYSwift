//
//  WeathrViewController.swift
//  JWatchWeatherProject
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import WatchWeatherKit

class WeathrViewController: UIViewController {
    
    @IBOutlet weak var backjgroundImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var lowLable: UILabel!
    
    var day: Day? {
        
         didSet {
            
            title = day?.title
            
        }
    
    }
    
    var weather: Weather? {
        
        didSet {
            
            title = weather?.day.title
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(weather)
        
        lowLable.text = "\(weather!.lowTemperature)"
        
        heightLabel.text = "\(weather!.hightTemperature)"
        
        let imageName: String
        
        switch weather!.state {
            
        case .Sunny: imageName = "sunny"
        
        case .Cloudy: imageName = "cloudy"
            
        case .Rain: imageName = "rain"
            
        case .Snow: imageName = "snow"
        
        }
        
        weatherImageView.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
