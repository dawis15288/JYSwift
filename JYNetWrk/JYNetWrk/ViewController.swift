//
//  ViewController.swift
//  JYNetWrk
//
//  Created by atom on 16/4/11.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        JYNet.request("GET", url: "https://cn.bing.com/dict/", dataForm: ["q": "jeopardize"], success: { (data) in
            
            print(String(data: data!, encoding: NSUTF8StringEncoding))
            
            }) { (error) in

                print(error?.localizedDescription)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

