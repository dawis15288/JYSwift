//
//  NewsListTableViewCell.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var newsImageViw: UIImageView!

    @IBOutlet weak var mutipiclabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
