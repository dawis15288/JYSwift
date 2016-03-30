//: Playground - noun: a place where people can play

import UIKit

import XCPlayground

import Eureka

var str = "Hello, playground"


var square = UIView()

square.backgroundColor = .greenColor()

square.frame = CGRectMake(0, 0, 50, 50)


var formVC = FormViewController()

let scetion = Section("Whitesmith Events")

scetion <<< TextRow() {
    
    $0.value = "Surprise!"

}

scetion <<< DateRow() {
    
    $0.value = NSDate()

}

formVC.form.append(scetion)

formVC.view.layer.cornerRadius = 50.0

formVC.view.layer.masksToBounds = true

//XCPlaygroundPage.currentPage.liveView = formVC

let item = ["One", "Two", "JY"]

let notificationsVC = UITableViewController()

class NotificationsDataSource: NSObject, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

class NotificationsTableDelegate: NSObject, UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = item[indexPath.row]
    }

}

let dataSource = NotificationsDataSource()

let tableDelegate = NotificationsTableDelegate()

notificationsVC.tableView.dataSource = dataSource

notificationsVC.tableView.delegate = tableDelegate

XCPlaygroundPage.currentPage.liveView = notificationsVC

