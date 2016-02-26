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
            
            //通过这个函数同时显示splitevc的两个视图！！！
            
           // self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: viewController)
        
        }
    
    }
    //在不同屏幕方向上显示不同的视图，在正常方向上显示主视图，在横屏上同时显示主副视图
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Regular {
            
            print("--------->>>>> traitCollection.verticalSizeClass")
            
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: viewController)
        
        } else {
            
            print("traitCollection.verticalSizeClass<<<<<<<-----------")
            
            self.setOverrideTraitCollection(nil, forChildViewController: viewController)
            
        }
        
        /*if size.width > size.height {
            
            //self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: viewController)
            
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: viewController)
        
        } else {
        
            self.setOverrideTraitCollection(nil, forChildViewController: viewController)
        
        }*/
        
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

}
