//
//  RfreshBottomView.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class RefreshBottomView: UIView, RefreshViewDelegate {
    
    private var _refreshControl: RefreshControl?
    
    let activityIndicatorView: UIActivityIndicatorView
    
    let loadingLbel: UILabel
    
    let promptLabel: UILabel
    
    var refreshControl: RefreshControl? {
        
        get {
            
            return _refreshControl
            
        }
        
        set {
            
            _refreshControl = newValue
        }
        
    }
    
    override init(frame: CGRect) {
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        
        loadingLbel = UILabel(frame: CGRectZero)
        
        promptLabel = UILabel(frame: CGRectZero)
        
        super.init(frame: frame)
        
        self.initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        
        loadingLbel = UILabel(frame: CGRectZero)
        
        promptLabel = UILabel(frame: CGRectZero)
        
        super.init(coder: aDecoder)
        
        self.initView()
        
    }
    
    func initView() {
        
        self.backgroundColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 237.0 / 255.0)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicatorView)
        
        
        loadingLbel.backgroundColor = UIColor.clearColor()
        
        loadingLbel.font = UIFont.systemFontOfSize(13)
        
        loadingLbel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(loadingLbel)
        
        
        promptLabel.backgroundColor = UIColor.clearColor()
        
        promptLabel.font = UIFont.systemFontOfSize(13)
        
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        
        promptLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(promptLabel)
        
        self.resetViews()
        
        self.resetLaboutSubViews()
    
    }
    
    func resetViews() {
        
        promptLabel.hidden = false
        
        promptLabel.text = "上拉加载更多"
        
        loadingLbel.hidden = true
        
        loadingLbel.text = "正在加载..."
        
        if self.activityIndicatorView.isAnimating() {
            
            self.activityIndicatorView.stopAnimating()
        
        }
    
    }
    
    func resetLaboutSubViews() {
        
        let tempContraint = self.constraints
        
        if tempContraint.count > 0 {
            
            self.removeConstraints(tempContraint)
        
        }
        
        UIView.animateWithDuration(0.25, animations: { [unowned self] () -> Void in
            
                let aTop = NSLayoutConstraint(item: self.activityIndicatorView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 13)
            
                let aRight = NSLayoutConstraint(item: self.activityIndicatorView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: -5)
            
            let aWidth = NSLayoutConstraint(item: self.activityIndicatorView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 35)
            
            let aheight = NSLayoutConstraint(item: self.activityIndicatorView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 35)
            
            self.addConstraints([aTop, aRight, aWidth, aheight])
            
            let tleft = NSLayoutConstraint(item: self.loadingLbel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            
            let tTop = NSLayoutConstraint(item: self.loadingLbel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
            
            let tRight = NSLayoutConstraint(item: self.loadingLbel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            
            let tHeight = NSLayoutConstraint(item: self.loadingLbel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 32)
            
            self.addConstraints([tleft, tTop, tRight, tHeight])
            
            let viewsDictionary = ["promptLabel": self.promptLabel]
            
            let pHList = NSLayoutConstraint.constraintsWithVisualFormat("H: |-0-[promptlabel]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary as [String: AnyObject])
            
            let pVList = NSLayoutConstraint.constraintsWithVisualFormat("V: |-0-[promptLabel(==45)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary as [String: AnyObject])
            
            
            self.addConstraints(pHList)
            
            self.addConstraints(pVList)
            
            })
    
    }
    
    
    
    func needContentInset(direction: RefreshDirection) -> Bool {
        
        return true
    }
    
    func canEngageRefresh(scrollView: UIScrollView, direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionBoottom {
            
            promptLabel.text = "松开即可加载"
            
        }
    }
    
    func didDisengageRefresh(scrollView: UIScrollView, direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionBoottom {
        
            self.resetViews()
        }
        
        
    }
    
    func startRefreshing(direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionBoottom {
            
            promptLabel.hidden = true
            
            loadingLbel.hidden = false
            
            self.activityIndicatorView.stopAnimating()
        
        }
        
    }
    
    func finishRefreshing(direction: RefreshDirection) {
        
        if direction == RefreshDirection.RefreshDirectionBoottom {
            
            self.resetViews()
        }
        
    }
    
}