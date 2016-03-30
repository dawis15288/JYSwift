//
//  MainTitleViewController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class MainTitleViewController: UIViewController, RefreshViewDelegate {
    
    private let BACKGROUND_COLOR_1 = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: 1)
    
    private let BACKKGROUND_COLOR_0 = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: 0)
    
    private var _refreshControl: RefreshControl?
    
    var mainTitleDelegate: MainTitleViewDelegate?
    
    var refreshController: RefreshControl? {
        
        get {
            
            return _refreshControl
            
        }
        
        set {
            
            _refreshControl = newValue
            
        }
        
    }
    
    //var mainTitleViewViewDelgate:
    
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var circularProgress: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: --- RefreshViewDelegate ---
    
    func needContentInset(direction: RefreshDirection) -> Bool {
        
        return true
    }
    
    func canEngageRefresh(scrollView: UIScrollView, direction: RefreshDirection) {
        
        
    }
    
    func didDisengageRefresh(scrollView: UIScrollView, direction: RefreshDirection) {
        
        if scrollView is UITableView {
            
            changeTitleViewAlpha(Float(scrollView.contentOffset.y))
            
            changeTitleAndTabkeHeader(Float(scrollView.contentOffset.y), scrollView: scrollView)
            
            showRefreshProgress(Float(scrollView.contentOffset.y))
        
        }
        
    }
    
    func startRefreshing(direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionTop {
        
            circularProgress.alpha = 0
            
            activtyIndicator.startAnimating()
            
            activtyIndicator.alpha = 1
        }
    }
    
    func finishRefreshing(direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionTop {
            
            self.activtyIndicator.stopAnimating()
            
            self.activtyIndicator.alpha = 1
            
            self.circularProgress.alpha = 0
        
        }
        
    }
    
    //MARK: -- change ---
    
    func changeTitleAndTabkeHeader(offset: Float, scrollView: UIScrollView) {
        
        let needY = IN_WINDOW_HEIGHT - SCROLL_HEIGHT - TITLE_HEIGHT
        
        let result = offset / needY
            
        if result > 1 {
            
            topHeaderView.backgroundColor = BACKGROUND_COLOR_1
            
            let tableView = scrollView as! UITableView
            
            let cellNumber = tableView.numberOfRowsInSection(0)
            
            let hiddenHeight = Float(cellNumber - 1 ) * TABLE_CELL_HEIGHT + SECTION_HEIGHT + needY
            
            if Float(scrollView.contentOffset.y) > hiddenHeight {
                
                titleLabel.alpha = 0
                
                self.view.backgroundColor = BACKKGROUND_COLOR_0
            
            } else {
            
                titleLabel.alpha = 1
            }
            
            scrollView.contentInset = UIEdgeInsets(top: CGFloat(100), left: 0, bottom: 0, right: 0)
        
        } else {
            
            topHeaderView.backgroundColor = UIColor.clearColor()
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        
        }
        
        
    
    }
    
    func changeTitleViewAlpha(offsetY: Float) {
        
        let needY = IN_WINDOW_HEIGHT - SCROLL_HEIGHT - TITLE_HEIGHT
        
        var result = offsetY / needY
        
        result = max(min(result, 1.0), 0.0)
        
        self.view.backgroundColor = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: CGFloat(result))
    
    }
    
    func showRefreshProgress(offset: Float) {
        
        var result = ( 0 - offset) / SCROLL_HEIGHT
        
        result = max(min(result, 1.0), 0.0)
        
        //circularProgress
    
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


protocol MainTitleViewDelegate {
    
    func doLeftAction()

}
