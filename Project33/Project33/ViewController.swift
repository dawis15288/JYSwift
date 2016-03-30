//
//  ViewController.swift
//  Project33
//
//  Created by atom on 15/11/25.
//  Copyright © 2015年 atom. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    static var dirty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Whats that whistle? "
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWhistle")
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .Plain, target: nil, action: nil)
        
        
    }
    
    func addWhistle() {
        
        //RecordWhistleViewController()
        
        let vc = RecordWhistleViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

