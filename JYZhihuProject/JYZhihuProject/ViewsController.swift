//
//  ViewsController.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate, RefreshControlDelegate, MainTitleViewDelegate, SlideScrollViewDelgate {
    
    private let BACKGROUND_COLOR = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: 1)
    
    var leftViewController: UIViewController?
    
    weak var mainTitleViewController: MainTitleViewController?
    
    var refreshBottomView: RefreshBottomView?
    
    var refreshControl: RefreshControl!
    
    let newsListControl: MainNewListControl = MainNewListControl()
    
    var longPress = UILongPressGestureRecognizer()

    @IBOutlet weak var mainTitleView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "NewsListTableViewCell", bundle: nil)
        
        mainTableView.registerNib(nib, forCellReuseIdentifier: "newsListTablkeViewCell")
        
        refreshControl = RefreshControl(scrollView: mainTableView, delegate: self)
        
        refreshControl.topEnabled = true
        
        refreshControl.bottomEnabled = true
        
        refreshControl.registeTopView(mainTitleViewController!)
        
        refreshControl.enableInsetTop = SCROLL_HEIGHT
        
        refreshControl.enableInsetBottom = 30
        
        let y = max(self.mainTableView.bounds.size.height, self.mainTableView.contentSize.height)
        
        refreshBottomView = RefreshBottomView(frame: CGRect(x: 0, y: y, width: self.mainTableView.bounds.size.width, height: CGFloat(refreshControl.enableInsetBottom + 45)))
        
        refreshControl.registeBottomView(refreshBottomView!)
        
        refreshBottomView?.resetLaboutSubViews()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        check3DTouch()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mainTitleView" {
            
            mainTitleViewController = segue.destinationViewController as? MainTitleViewController
            
            mainTitleViewController?.mainTitleDelegate = self
        
        } else if segue.identifier == "pushSegue" {
            
            let newsDetailViewControllr = segue.destinationViewController as? NewsDetailViewController
            
            if newsDetailViewControllr?.newsListControl == nil {
                
                newsDetailViewControllr?.newsListControl = self.newsListControl
                
                newsDetailViewControllr?.mainViewController = self
            
            }
            
            var index = sender as? NSIndexPath
            
            if index == nil {
                
                let command = sender as! String
                
                if "newNews" == command {
                    
                    index = NSIndexPath(forRow: 1, inSection: 0)
                
                } else if "xiacheNews" == command {
                    
                    let todayNws = self.newsListControl.todayNews?.news
                
                }
            
            }
        
        }
    }
    
    func check3DTouch() {
        
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            
            self.registerForPreviewingWithDelegate(self, sourceView: self.view)
            
            self.longPress.enabled = false
        
        } else {
            
            self.longPress.enabled = true
        
        }
    
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
