//
//  ViewController.swift
//  JYTapDemo
//
//  Created by atom on 16/1/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var pictrueView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap = UITapGestureRecognizer(target: self, action: "imageTapped:")
        
        self.pictrueView.addGestureRecognizer(tap)
        
        //self.view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: "popoverImage:")
        
        
    }
    
    func popoverImage() {
        
        print("some")
    
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        
        
    
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    @IBAction func popoverVC(sender: AnyObject) {
        
        let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as? PopoverViewController
        
        popoverViewController?.modalPresentationStyle = .FormSheet
        
        popoverViewController?.popoverPresentationController?.delegate = self
        
        let button = sender as! UIButton
            
           // popoverViewController?.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        
        
        popoverPresentationController?.permittedArrowDirections = .Up
        
        presentViewController(popoverViewController!, animated: true, completion: {() -> Void in
            
            print("popover")
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

