//
//  ViewController.swift
//  JYPullRefrshProject
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var refreshController = UIRefreshControl()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        self.refreshController.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(refreshController)
        
    }
    
    func refresh(sender: AnyObject) {
        
        self.loadStockQuoteItems()
    
    }
    
    func loadStockQuoteItems() {
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

