//
//  ViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var sideScrollView: UIScrollView!

    @IBOutlet weak var leftView: UIView!
    
    var showingMnu = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func hideOrShowMenu(show: Bool, animated: Bool) {
    
        let menuOffset = CGRectGetWidth(leftView.bounds)
        
        sideScrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
        
        showingMnu = show
        
        print("fhideOrShowMenu(show: Bool, animated: Bool)")
    
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        print("func viewDidLayoutSubviews()")
        
        hideOrShowMenu(showingMnu, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
        
        
    }
    
    // MARK: - silde view delegate
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
            let bool = sideScrollView.contentOffset.x < CGRectGetWidth(leftView.bounds) / 2
            
            hideOrShowMenu(bool, animated: true)
        
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let bool = sideScrollView.contentOffset.x < CGRectGetWidth(leftView.bounds) / 2
        
        hideOrShowMenu(bool, animated: true)
    }


}

