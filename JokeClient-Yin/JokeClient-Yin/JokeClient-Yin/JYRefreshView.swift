//
//  JYRefreshView.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

protocol JYRefreshViewDelegate {
    
    func refreshView(refreshView: JYRefreshViewController, didClickButton btn: UIButton)
    

}

class JYRefreshViewController: UITableViewCell {
    @IBOutlet weak var refrshBtn: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var delegate: JYRefreshViewDelegate!
    
    
    @IBAction func buttonClicked(sender: AnyObject) {
        
        self.delegate.refreshView(self, didClickButton: sender as! UIButton)
        
    }
    func startLoadng() {
        
        self.refrshBtn.setTitle("", forState: .Normal)
        
        self.indicator.hidden = false
        
        self.indicator.startAnimating()
    
    }
    
    func stopLoading() {
        
        self.refrshBtn.setTitle("点击加载更多", forState: .Normal)
        
        self.indicator.hidden = true
        
        self.indicator.stopAnimating()
    
    
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
