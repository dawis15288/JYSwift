//
//  ContainerViewController.swift
//  JYSplitAndPPopover
//
//  Created by atom on 16/1/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController: UISplitViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        if size.width > size.height {
            
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: viewController)
        
        } else {
            
            self.setOverrideTraitCollection(nil, forChildViewController: viewController)
        
        }
        
        if self.traitCollection.verticalSizeClass == .Regular {
        
            super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
            
        }
        
        
    }
    
    func setEmbeddedViewController(splitViewController: UISplitViewController!) {
        
        if splitViewController != nil {
            
            viewController = splitViewController
            
            self.addChildViewController(viewController)
            
            self.view.addSubview(viewController.view)
            
            viewController.didMoveToParentViewController(self)
            
           // self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: viewController)
            
        }
        
        
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
