//
//  ViewController.swift
//  JYLazy
//
//  Created by atom on 16/4/7.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /*
        
        dispatch_async(serialDispatchQueue) {
            
            print("1")
        }
        
        dispatch_async(serialDispatchQueue) {
            
            sleep(2)
            
            print("2")
        }
        
        dispatch_async(serialDispatchQueue) {
            
            sleep(1)
            
            print("3")
        }
        
        
        
        dispatch_async(concurrentDispatchQueue) { 
            print("11")
        }
        
        dispatch_async(concurrentDispatchQueue) {
            sleep(2)
            print("22")
        }
        
        dispatch_async(concurrentDispatchQueue) {
            sleep(1)
            print("33")
        }*/
        
        /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print("异步任务")
            dispatch_async(dispatch_get_main_queue(), { 
                
                print("异步主线程")
            })
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) { 
            print("DISPATCH_QUEUE_PRIORITY_LOW")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            print("DISPATCH_QUEUE_PRIORITY_HIGH")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            print("DISPATCH_QUEUE_PRIORITY_BACKGROUND")
        }
        
        let serialDispatchQueue = dispatch_queue_create("cm.text.queue", nil)
        
        let dispatchgetglobalqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        dispatch_set_target_queue(serialDispatchQueue, dispatchgetglobalqueue)
        
        dispatch_async(serialDispatchQueue) { 
            print("low")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print("no low")
        }*/
        
       /* print("---+++---")
        
        let delayInSeconds: UInt64 = 2
        
        let sleep = delayInSeconds * NSEC_PER_SEC
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(sleep))
        
        dispatch_after(popTime, dispatch_get_main_queue()) { 
            
            print("xxxxx")
        }*/
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        let group = dispatch_group_create()
        
        dispatch_group_async(group, queue) { 
            print("0")
        }
        
        dispatch_group_async(group, queue) {
            print("1")
        }
        
        dispatch_group_async(group, queue) {
            print("2")
        }
        
        dispatch_group_async(group, queue) {
            print("3")
        }
        
        dispatch_group_notify(group, queue) { 
            
            print("down")
        }
        
        let concurrentDispatchQueue = dispatch_queue_create("com.test.jy", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(concurrentDispatchQueue) { 
            print("0")
        }
        
        dispatch_async(concurrentDispatchQueue) {
            print("0")
        }
        
        dispatch_async(concurrentDispatchQueue) {
            print("1")
        }
        dispatch_async(concurrentDispatchQueue) {
            print("2")
        }
        dispatch_async(concurrentDispatchQueue) {
            print("3")
        }
        
        dispatch_barrier_async(concurrentDispatchQueue) { 
            print("4__")
        }
        
        dispatch_async(concurrentDispatchQueue) {
            print("555")
        }
        dispatch_async(concurrentDispatchQueue) {
            print("6")
        }
        dispatch_async(concurrentDispatchQueue) {
            print("7")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

