//
//  RefreshViewDelegate.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

protocol RefreshViewDelegate {

    var refreshControl: RefreshControl? { get set }
    
    func needContentInset(direction: RefreshDirection) -> Bool
    
    func startRefreshing(direction: RefreshDirection)
    
    func canEngageRefresh(scrollView: UIScrollView, direction: RefreshDirection)
    
    func didDisengageRefresh(scrollView: UIScrollView, direction: RefreshDirection)
    
    func finishRefreshing(direction: RefreshDirection)

}