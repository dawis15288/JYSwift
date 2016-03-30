//
//  RefreshControlDelegate.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


protocol RefreshControlDelegate {
    
    func refreshControl(refreshControl: RefreshControl, didEngageRefreshDirection direction: RefreshDirection)

}