//
//  VideoViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var jytableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUIS()
        
    }
    
    
    private func setupUIS() {
        
        jytableView = jyTableView
        
        self.view.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(jyTableView)
        
        let width = UIScreen.mainScreen().bounds.width
        
        let height = UIScreen.mainScreen().bounds.height
        
        jyTableView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: CGSize(width: width, height: height), offset: CGPoint(x: 0, y: 0))
        
        jyTableView.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var jyTableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: AllReuseIdentifier)
        
        tableView.dataSource = self
        
        return tableView
        
        
    }()

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

extension VideoViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(AllReuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = "AllReuseIdentifier"
        
        return cell
        
    }
    
}
