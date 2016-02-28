//
//  JYMainViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYMainViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var sideScrollViw: UIScrollView!
    @IBOutlet weak var leftView: UIView!
    
    var showingMenu = false
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        hideOrShowMenu(showingMenu, animated: false)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("viewDidLoad()")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideOrShowMenu(show: Bool, animated: Bool) {
        
        let menuOffset = CGRectGetWidth(leftView.bounds)
        
        print(menuOffset)
        
        //sideScrollViw.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0) , animated:  animated)
        
        let contentOffset = show ? CGPointZero : CGPoint(x: menuOffset, y: 0)
        
        sideScrollViw.setContentOffset(contentOffset, animated: animated)
        
        showingMenu = show
        
    
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            let bool = ( sideScrollViw.contentOffset.x < CGRectGetWidth(leftView.bounds) / 2 )
            
            hideOrShowMenu(bool, animated: true)
        
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let bool = ( sideScrollViw.contentOffset.x < CGRectGetWidth(leftView.bounds) / 2 )
        
        hideOrShowMenu(bool, animated: true)
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
