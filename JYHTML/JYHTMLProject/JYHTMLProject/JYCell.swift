//
//  JYCell.swift
//  JYHTMLProject
//
//  Created by atom on 16/2/17.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCell: UITableViewCell {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        title.text = ""
        
        progressBar.progress = 0
        
        progressBar.hidden = true
        
        accessoryType = .None
    }

}
