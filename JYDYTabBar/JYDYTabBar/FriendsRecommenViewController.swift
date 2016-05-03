//
//  FriendsRecommenViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import MJRefresh

import Alamofire

let CategoryReuseIdentifier = "JYCategoryCell"

let CategoryUserReuseIdentifier = "JYCategoryUserCell"

class FriendsRecommenViewController: UIViewController {
    
    var seletcorCategor: Category?
    
    var preCategor: Category?
    
    var preID: String?
    
    var categoryData: [Category]? {
        
        didSet {
            
            self.categryTableView.reloadData()
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            self.categryTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
            
            self.seletcorCategor = getSelectorUser()
            
            self.categryUserTableView.mj_header.beginRefreshing()
        
        }
    
    }
    
    let  footer = MJRefreshAutoNormalFooter()
    
    let header = MJRefreshNormalHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "推荐关注"
        
        setupTableView()
        
        self.view.backgroundColor = UIColor.grayColor()
        
        BudejieNetTool.CategoryData { (category, errr) in
            
            if category != nil && errr == nil {
                
                self.categoryData = category
                
            }
            
        }
        
    }
    
    private func setupTableView() {
    
        view.addSubview(categryTableView)
        
        view.addSubview(categryUserTableView)
        
       
        
        let heght = UIScreen.mainScreen().bounds.height
        
        let width = UIScreen.mainScreen().bounds.width
        
        categryTableView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: 70, height: heght), offset: CGPoint(x: 0, y: 0))
        
        categryUserTableView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: categryTableView, size: CGSize(width: width - 70, height: heght), offset: CGPoint(x: 0, y: 64))
    
    }
    
    

    private lazy var categryTableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.registerClass(JYCategoryCell.self, forCellReuseIdentifier: CategoryReuseIdentifier)
        return tableView
    
    }()
    
    private lazy var categryUserTableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        //refreshingTarget: self, refreshingAction: #selector(loadNextPageData)
        
        //refreshingTarget: self, refreshingAction: #selector(loadNextPageData)
        
        self.header.setRefreshingTarget(self, refreshingAction: #selector(loadFirstPageData))
        
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(loadNextPageData))
        
        
        tableView.mj_header = self.header
        
        tableView.mj_footer = self.footer
        
        tableView.mj_footer.hidden = true
        
        tableView.registerClass(JYCategoryUserCell.self, forCellReuseIdentifier: CategoryUserReuseIdentifier)
        return tableView
        
    }()
    
    @objc private func loadFirstPageData() {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (__int64_t)( 4 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            
            BudejieNetTool.listData(self.seletcorCategor!.id, nextPage: 1) { (categoryUser, errr) in
                
                if categoryUser != nil && errr == nil {
                    
                    self.seletcorCategor!.categoryUsers = categoryUser
                    
                    self.categryUserTableView.reloadData()
                    
                    self.categryUserTableView.mj_header.endRefreshing()
                    
                    if self.seletcorCategor!.categoryUsers?.count == categoryUser!.last?.total{
                        
                        self.categryUserTableView.mj_footer.endRefreshingWithNoMoreData()
                        
                    } else {
                        
                        self.seletcorCategor!.nextPage = self.seletcorCategor!.nextPage + 1
                        
                    }
                    
                }
                
            }
            
            
        }
        
        
    
    }
    
    @objc private func loadNextPageData() {
        
        if let index = self.categryTableView.indexPathForSelectedRow {
            
            let cate = self.categoryData![index.row]
            
                BudejieNetTool.listData(cate.id, nextPage: cate.nextPage, completeHandler: { (categoryUser, errr) in
                    
                    if categoryUser != nil && errr == nil {
                        
                        cate.categoryUsers! =  cate.categoryUsers! + categoryUser!
                        
                        self.categryUserTableView.reloadData()
                        
                        if cate.categoryUsers?.count == categoryUser?.last?.total {
                            
                            cate.nextPage = 1
                            
                            self.footer.endRefreshingWithNoMoreData()
                            
                        } else {
                            
                            cate.nextPage = cate.nextPage + 1
                            
                            self.footer.endRefreshing()
                            
                        }
                        
                        
                        
                        
                    }
                
            
            })
            
            
            
        }
        
    }
    
    func getSelectorUser() -> Category? {
        
        if let selectorIndex = self.categryTableView.indexPathForSelectedRow {
            
            return self.categoryData![selectorIndex.row]
            
        } else {
            
            return nil
        
        }
    
    }
    
    deinit {
        
    
    }

}

extension FriendsRecommenViewController: UITableViewDataSource, UITableViewDelegate {
    
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.categryTableView == tableView {
            
             return self.categoryData?.count ?? 0
        
        } else {
            
            let selectorCategory = getSelectorUser()
            
            if selectorCategory != nil {
                
                if seletcorCategor?.categoryUsers != nil {
                    
                    self.categryUserTableView.mj_footer.hidden = ( selectorCategory!.categoryUsers?.count == 0 )
                    
                    return selectorCategory!.categoryUsers?.count ?? 0
                
                }
            
            }
            
            return 0
        
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if self.categryTableView == tableView {
            
           let cell = tableView.dequeueReusableCellWithIdentifier(CategoryReuseIdentifier, forIndexPath: indexPath) as! JYCategoryCell
            
            let categor = self.categoryData![indexPath.row]
            
            cell.textLabel?.text = categor.name
            
            return cell
            
        } else {
        
            let cell = tableView.dequeueReusableCellWithIdentifier(CategoryUserReuseIdentifier, forIndexPath: indexPath) as! JYCategoryUserCell
            
            let selectorIndex = self.categryTableView.indexPathForSelectedRow?.row
            
            let selectorCategory = self.categoryData![selectorIndex!]
            
            let selectorUser = selectorCategory.categoryUsers?[indexPath.row]
                
            cell.categoryUser = selectorUser
                
            return cell
        
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        if self.categryTableView == tableView {
            
            seletcorCategor = self.categoryData![indexPath.row]
            
            self.categryUserTableView.mj_footer.resetNoMoreData()
            
            if seletcorCategor!.categoryUsers != nil {
                
                if self.seletcorCategor!.categoryUsers?.count == self.seletcorCategor!.categoryUsers?.last?.total {
                    
                    self.categryUserTableView.mj_footer.endRefreshingWithNoMoreData()
                
                }
                
                self.categryUserTableView.reloadData()
            
            
            } else {
                
                self.categryUserTableView.reloadData()
                
                self.categryUserTableView.mj_footer.hidden = true
                
                self.categryUserTableView.mj_header.beginRefreshing()
                    
                   /* BudejieNetTool.listData(self.seletcorCategor!.id, nextPage: 1) { (categoryUser, errr) in
                        
                        if categoryUser != nil && errr == nil {
                            
                                self.seletcorCategor!.categoryUsers = categoryUser
                            
                                self.categryUserTableView.reloadData()
                            
                                if self.seletcorCategor!.categoryUsers?.count == categoryUser!.last?.total{
                                
                                    self.categryUserTableView.mj_footer.endRefreshingWithNoMoreData()
                                
                                } else {
                                
                                    self.seletcorCategor!.nextPage = self.seletcorCategor!.nextPage + 1
                                
                                }
                            
                        }
                        
                    }*/
            
            
            }
            
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        if self.categryTableView == tableView {
            
            return 64
        
        } else {
        
            return 84
        }
    
    }
    
}
