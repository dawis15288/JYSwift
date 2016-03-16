//
//  QRCodViewControllerCatgroy.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension QRCodeViewController: UITabBarDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        self.scanLineView.layer.removeAllAnimations()
        
        if item.tag == 0 {
            
            containHeightCons.constant = 300
            
        } else if item.tag == 1 {
            
            containHeightCons.constant = 300 * 0.5
            
        }
        
        //containHeightCons.constant = item.tag == 0 ? 300 : 300 * 0.5
        
        //self.scanLineView.layer.removeAllAnimations()
        
        startAnmiation()
    }
    
}
