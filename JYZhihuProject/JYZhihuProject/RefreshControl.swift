//
//  RefreshControl.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

enum RefreshingDirections {
    
    case RefreshingDirectionNone
    
    case RefreshingDirectionTop
    
    case RefreshingDirectionBoottom

}

enum RefreshDirection {
    
    case RefreshDirectionTop
    
    case RefreshDirectionBoottom

}

class RefreshControl: NSObject {
    
    var refreshingDirection: RefreshingDirections {
        
        get {
            
            return _refreshingDirection
        
        }
    
    }
    
    private var _refreshingDirection: RefreshingDirections = .RefreshingDirectionNone
    
    var scrollView: UIScrollView
    
    var delegate: RefreshControlDelegate
    
    var topEnabled: Bool = false
    
    var bottomEnabled: Bool = false
    
    var enableInsetTop: Float = 65
    
    var enableInsetBottom: Float = 65
    
    var autoRefreshTop: Bool = false
    
    var autoRefreshBottom: Bool = false
    
    private var topView: RefreshViewDelegate?
    
    private var bootomView: RefreshViewDelegate?
    
    init(scrollView: UIScrollView, delegate: RefreshControlDelegate) {
        
        self.scrollView = scrollView
        
        self.delegate = delegate
        
         super.init()
        
        self.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.New, .Old], context: nil)
        
        self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.New, .Old], context: nil)
        
    }
    
    deinit {
        
        self.scrollView.removeObserver(self, forKeyPath: "contentSize")
        
        self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if "contentSize" == keyPath {
            
            if self.topEnabled {
            }
            
            if self.bottomEnabled {
            }
        
        } else if "contentOffset" == keyPath {
            
            if self.refreshingDirection == .RefreshingDirectionNone {
                
                self.drogForChange(change!)
            }
        
        }
    }
    
    func drogForChange(change: [NSObject: AnyObject]) {
        
        if self.scrollView.contentOffset.y < 0 {
            
            if -Float(self.scrollView.contentOffset.y) >= self.enableInsetTop {
                
                if self.autoRefreshTop || ( self.scrollView.decelerating && !self.scrollView.dragging) {
                    
                    self.enagaRefreshDicrection(.RefreshDirectionTop)
                
                } else {
                    
                    self.canEngageRefreshDirection(.RefreshDirectionTop)
                
                }
            
            } else {
                
                self.canEngageRefreshDirection(.RefreshDirectionTop)
            
            }
        
        }
        
        if self.scrollView.contentOffset.y > 0 {
            
            let result = Float(self.scrollView.contentSize.height) + self.enableInsetBottom - Float(self.scrollView.bounds.height)
            
            print("self.scrollView.contentOffset.y > 0 >> \(result)\n")
            
            if Float(self.scrollView.contentOffset.y) >= result {
                
                if self.autoRefreshBottom || (self.scrollView.decelerating && !self.scrollView.dragging) {
                    
                    self.enagaRefreshDicrection(.RefreshDirectionBoottom)
                
                } else {
                    
                    self.canEngageRefreshDirection(.RefreshDirectionBoottom)
                
                }
            
            } else {
                
                self.didDisengageRefreshDirection(.RefreshDirectionBoottom)
            
            }
        
        }
    
    }
    
    private func enagaRefreshDicrection(direction: RefreshDirection) {
        
        var edge: UIEdgeInsets = UIEdgeInsetsZero
        
        if direction == .RefreshDirectionTop {
            
            self._refreshingDirection = .RefreshingDirectionTop
            
            let topH = self.enableInsetTop < 45 ? 45 : self.enableInsetTop
            
            edge = UIEdgeInsets(top: CGFloat(topH), left: 0, bottom: 0, right: 0)
            
            if let t = self.topView {
                
                if t.needContentInset(direction) {
                
                    self.scrollView.contentInset = edge
                }
            
            }
        
        } else if direction == .RefreshDirectionBoottom {
            
            
            let bottomH = self.enableInsetBottom < 45 ? 45 : self.enableInsetBottom
            
            edge = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(bottomH), right: 0)
            
            self._refreshingDirection = .RefreshingDirectionBoottom
            
            if let t = self.bootomView {
                
                if t.needContentInset(direction) {
                    
                    self.scrollView.contentInset = edge
                
                }
            
            }
        
        }
        
        self.didEngagRefreshDirection(direction)
    
    }
    
    private func canEngageRefreshDirection(direction: RefreshDirection) {
        
        if let top = self.topView {
            
            top.canEngageRefresh(self.scrollView, direction: direction)
        
        }
        
        if let bottom = self.bootomView {
            
            bottom.canEngageRefresh(self.scrollView, direction: direction)
        
        }
    
    }
    
    private func didEngagRefreshDirection(direction: RefreshDirection) {
        
        if let top = self.topView {
            
            top.startRefreshing(direction)
        
        }
        
        if let bottom = self.bootomView {
        
            bottom.startRefreshing(direction)
        }
        
        self.delegate.refreshControl(self, didEngageRefreshDirection: direction)
    
    }
    
    private func didDisengageRefreshDirection(direction: RefreshDirection) {
        
        if let top = self.topView {
            
            top.didDisengageRefresh(self.scrollView, direction: .RefreshDirectionTop)
        
        }
        
        if let bottom = self.bootomView {
            
            bottom.didDisengageRefresh(self.scrollView, direction: .RefreshDirectionBoottom)
        
        }
    
    }
    
    private func startRefreshingDirection(direction: RefreshDirection, animation: Bool) {
        
        var point = CGPointZero
        
        if direction == .RefreshDirectionTop {
            
            let topH = self.enableInsetTop < 45 ? 45 : self.enableInsetTop
            
            point = CGPoint(x: 0, y: CGFloat(-topH))
            
            
        
        } else if direction == .RefreshDirectionBoottom {
            
            let height = max(self.scrollView.contentSize.height, self.scrollView.frame.height)
            
            let bottom = self.enableInsetBottom < 45 ? 45 : self.enableInsetBottom
            
            let result = height - self.scrollView.bounds.height + CGFloat(bottom)
            
            point = CGPoint(x: 0, y: result)
        
        }
        
        self.scrollView.setContentOffset(point, animated: true)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [unowned self ] () -> Void in
            
            self.enagaRefreshDicrection(direction)
        
        })
    
    }
    
    private func finishRefreshingDirection(direction: RefreshDirection, animation: Bool) {
        
        self._refreshingDirection = .RefreshingDirectionNone
        
        if let top = self.topView {
            
            top.finishRefreshing(direction)
        }
        
        if let bottom = self.bootomView {
            
            bottom.finishRefreshing(direction)
        
        }
    
    }
    
    func startRfreshingDirection(direction: RefreshDirection) {
        
        self.startRefreshingDirection(direction, animation: true)
    
    }
    
    func finishRefreshingDirection(direction: RefreshDirection) {
    
        self.finishRefreshingDirection(direction, animation: true)
    
    }
    
    func registeTopView<T where T: RefreshViewDelegate>(topView: T) {
    
        self.topView = topView
        
        self.topView?.refreshControl = self
    }
    
    func registeBottomView<T where T: RefreshViewDelegate>(bottomView: T) {
        
        self.bootomView = bottomView
        
        self.bootomView?.refreshControl = self
    
    }
    
}
