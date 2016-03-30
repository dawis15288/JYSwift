//
//  DetailViewController.swift
//  Project1
//
//  Created by atom on 15/10/29.
//  Copyright © 2015年 atom. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    @IBOutlet weak var detailImageView: UIImageView!
    
    
    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            /*if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }*/
            
            if let imageView = self.detailImageView {
                
                self.navigationItem.title = detail
                
                imageView.image = UIImage(named: detail)
            
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
        
    }


}

