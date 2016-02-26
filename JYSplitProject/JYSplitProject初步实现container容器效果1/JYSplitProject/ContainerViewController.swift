//
//  ContainerViewController.swift
//  JYSplitProject
//
//  Created by atom on 16/2/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController: UISplitViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setEmbeddeViewController(splitViewController: UISplitViewController!) {
        
        if splitViewController != nil {
            
            viewController = splitViewController
            
            self.addChildViewController(viewController)
            
            //That’s important to do, otherwise nothing is going to appear.
            
            self.view.addSubview(viewController.view)
            
            viewController.didMoveToParentViewController(self)
        
        }
    
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
