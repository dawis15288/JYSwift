//
//  InterfaceController.swift
//  JYHelloWatch WatchKit Extension
//
//  Created by atom on 16/1/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var displayLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    @IBAction func buttonTapped() {
        
        displayLabel.setText("Hello World!")
        
        displayLabel.setTextColor(UIColor.blueColor())
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
