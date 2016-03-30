//
//  TaskListViewController.swift
//  JYRealmProject
//
//  Created by atom on 16/2/20.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import RealmSwift

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskListTableView: UITableView!
    
    
    var selectedList: TaskList!
    
    var openTasks: Results<Task>!
    
    var completedTasks: Results<Task>!
    
    var currentCreatedAction: UIAlertAction!
    
    var isEditingMode = false
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //self.title = selectedList.name
        
       print(selectedList.name)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       self.title = selectedList.name
        
        readTaskAndUpdatUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readTaskAndUpdatUI() {
            
        completedTasks = selectedList.tasks.filter("isCompleted = true")
            
        openTasks = selectedList.tasks.filter("isCompleted = false")
        
        print(completedTasks)
        
        self.taskListTableView.reloadData()
        
    }
    
    func taskNameFieldDidChange(textField: UITextField) {
        
        self.currentCreatedAction.enabled = textField.text?.characters.count > 0
        
    }
    
    @IBAction func didClickOnEditButton(sender: AnyObject) {
        
        isEditingMode = !isEditingMode
        
        self.taskListTableView.setEditing(isEditingMode, animated: true)
        
    }
    
    @IBAction func didClickOnAddButton(sender: AnyObject) {
        
        self.displayAlertToAddTask(nil)
        
    }
    
    func displayAlertToAddTask(updatedTask: Task!) {
        
        var title = "New Task"
        
        var doneTitle = "Create"
        
        if updatedTask != nil {
            
            title = "update Task"
            
            doneTitle = "Update"
            
        }
        
        let alertController = UIAlertController(title: title, message: "Write the name of your task.", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler({ [unowned self ] (textField) -> Void in
            
            textField.placeholder = "Task name"
            
            textField.addTarget(self, action: "taskNameFieldDidChange:", forControlEvents: .EditingChanged)
            
            if updatedTask != nil {
                
                textField.text = updatedTask.name
                
            }
            
            
            })
        
        let createAction = UIAlertAction(title: doneTitle, style: .Default, handler: { [ unowned self ](action) -> Void in
            
            let taskNames = alertController.textFields?.first?.text
            
            if updatedTask != nil {
                
                do {
                    
                    try uiRealm.write( { () -> Void in
                        
                        updatedTask.name = taskNames!
                        
                    })
                    
                } catch _ {
                    
                    
                }
                
            } else {
                
                let newTask = Task()
                
                newTask.name = taskNames!
                
                do {
                    
                    try uiRealm.write({ () -> Void in
                        
                        self.selectedList?.tasks.append(newTask)
                        
                        print(self.selectedList?.tasks)
                        
                        self.readTaskAndUpdatUI()
                        
                    })
                    
                } catch {}
                
            }
            
            })
        
        createAction.enabled = false
        
        currentCreatedAction = createAction
        
        alertController.addAction(createAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - UITbleViewController datasource delegate --
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
                
            return openTasks.count
            
        } else {
                
            return completedTasks.count
            
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var task: Task!
        
        if indexPath.section == 0 {
            
           
                
                task = openTasks[indexPath.row]
            
            
        } else {
                
                task = completedTasks[indexPath.row]
            
        }
        
        cell.textLabel?.text = task?.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
        
            return "Open Tasks"
        
        } else {
        
            return "Complted Tasks"
        }
        
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
