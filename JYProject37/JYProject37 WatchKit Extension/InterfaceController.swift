//
//  InterfaceController.swift
//  JYProject37 WatchKit Extension
//
//  Created by atom on 16/2/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var welcomeText: WKInterfaceLabel!
    @IBOutlet var hideButton: WKInterfaceButton!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    @IBAction func hideWelcomeText() {
        
        welcomeText.setHidden(true)
        
        hideButton.setHidden(true)
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        WKInterfaceDevice().playHaptic(.Click)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            
            let session = WCSession.defaultSession()
            
            session.delegate = self
            
            session.activateSession()
        
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
