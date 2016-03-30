//
//  ViewController.swift
//  JYRealmProject
//
//  Created by atom on 16/2/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var lists: Results<TaskList>!
    
    var isEditingMode = false
    
    var currentCreateAction : UIAlertAction!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        readTasksAndUpdateUI()
        
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }
    
    func readTasksAndUpdateUI() {
        
        lists = uiRealm.objects(TaskList)
        
        print(lists)
        
        let segmentControl = UISegmentedControl(items: ["A_Z", "Date"])
    
        segmentControl.addTarget(self, action: "didSelected:", forControlEvents: UIControlEvents.ValueChanged)
        
        segmentControl.selectedSegmentIndex = 0
        
        tableView.tableHeaderView = segmentControl
        
        self.tableView.setEditing(false, animated: true)
        
        self.tableView.reloadData()
    
    }
    
    func didSelected(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            print(sender.selectedSegmentIndex)
            
            self.lists = self.lists.sorted("name")
            
        
        } else {
            
            self.lists = self.lists.sorted("createdAt", ascending: false)
        
        }
        
       self.tableView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - user actions - navgation item
    
    @IBAction func didClickOnEditButton(sender: AnyObject) {
        
        isEditingMode = !isEditingMode
        
        self.tableView.setEditing(isEditingMode, animated: true)
        
    }
    
    @IBAction func didClickOnAddButton(sender: AnyObject) {
        
        self.displayAlertToAddTask(nil)
        
    }
    
    
    func displayAlertToAddTask(updatedList: TaskList!) {
        
        var title = "new tasks list"
        
        var doneTitle = "Create"
        
        if updatedList != nil {
            
            title = "Update Tasks list"
            
            doneTitle = "update"
        
        }
        
        let alertController = UIAlertController(title: title, message: "Write the name of your tasks list.", preferredStyle: .Alert)
        
        let createAction = UIAlertAction(title: doneTitle, style: .Default, handler: { [ unowned self](action) -> Void in
            
            print("\(alertController.textFields?.first?.text)")
            
            let listName = alertController.textFields?.first?.text
            
            if updatedList != nil {
                
                do {
                
                    try uiRealm.write({ () -> Void in
                        
                        updatedList.name = listName!
                        
                        self.readTasksAndUpdateUI()
                        
                    })
                
                } catch _ {
                
                }
            
            } else {
                
                let newTaskList = TaskList()
                
                newTaskList.name = listName!
                
                do {
                    
                    try uiRealm.write({ () -> Void in
                        
                        uiRealm.add(newTaskList)
                        
                        self.readTasksAndUpdateUI()
                    
                    })
                
                } catch _ {}
            
            }
            
            print(listName)
        
        
        })
        
        alertController.addAction(createAction)
        
        createAction.enabled = false
        
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            
            textField.placeholder = "Task List Name"
            
            textField.addTarget(self, action: "listNameFieldDidChange:", forControlEvents: .EditingChanged)
            
            if updatedList != nil {
                
                textField.text = updatedList.name
            
            }
        
        })
        
        
        presentViewController(alertController, animated: true, completion: nil)
    
    }
    
    func listNameFieldDidChange(sender: UITextField) {
        
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
    
    }
    
    // MARK: UITableViewController data delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       return 1
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let listTasks = lists {
            
            print(listTasks.count)
            
            return listTasks.count
        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath)
        
        let list = lists[indexPath.row]
        
        print(list)
        
        cell.textLabel?.text = list.name
        
        cell.detailTextLabel?.text = "\(list.tasks.count) Tasks"
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete", handler: { (deleteAction, indexPath) -> Void in
            
            let listBeDelete = self.lists[indexPath.row]
            
            do {
                
                try uiRealm.write({() -> Void in
                        
                        uiRealm.delete(listBeDelete)
                    
                })
            
            } catch _ {
            
            
            
            }
        
        })
        
        let editAction = UITableViewRowAction(style: .Normal, title: "Edit", handler: { (editAction, indexPath) -> Void in
        
            let listToBeUpdated = self.lists[indexPath.row]
            
            self.displayAlertToAddTask(listToBeUpdated)
            
            
        
        })
        
        return [deleteAction, editAction]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //
        
        /*let tasksViewController = TaskListViewController()
        
        tasksViewController.selectedList = self.lists[indexPath.row]
        
        print("\(self.lists[indexPath.row])")
        
        navigationController?.pushViewController(tasksViewController, animated: true)*/
        
        self.performSegueWithIdentifier("openTasks", sender: self.lists[indexPath.row])
        
        print(self.tableView)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let tasksViewController = segue.destinationViewController as! TaskListViewController
        
        print(sender)
        
        tasksViewController.selectedList = sender as! TaskList
    }

}

