//
//  ProfileViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/18.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        
        
    }
    
    private func setupNav() {
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "friendsRecommentIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addFriendsRecommen))
    }
    
    func addFriendsRecommen() {
        
        let friendsRecommenVC = FriendsRecommenViewController()
        
        navigationController?.pushViewController(friendsRecommenVC, animated: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    

}
