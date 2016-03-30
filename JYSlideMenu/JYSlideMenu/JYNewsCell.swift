//
//  JYNewsCell.swift
//  JYSlideMenu
//
//  Created by atom on 16/2/16.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYNewsCell: UITableViewCell {

    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
