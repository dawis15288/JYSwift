//
//  JYPageViewController.swift
//  JYPageProject
//
//  Created by atom on 16/1/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        
        }
        
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        
        return [self.newColoredViewController("Green"),
        
                self.newColoredViewController("Red"),
            
                self.newColoredViewController("Blue")]
    
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("\(color)ViewController")
    
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

extension JYPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else { return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return orderedViewControllers.last}
        
        guard orderedViewControllers.count > previousIndex else { return nil}
        
        
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else { return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        let ordderedViewControllerCount = orderedViewControllers.count
        
        guard ordderedViewControllerCount != nextIndex  else { return orderedViewControllers.first }
        
        guard ordderedViewControllerCount > nextIndex else { return nil}
        
        return orderedViewControllers[nextIndex]
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first else { return 0 }
        
        guard let firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else { return 0 }
        
        return firstViewControllerIndex
        
        
    }
    
    
}
