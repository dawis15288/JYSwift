//
//  VideoCell.swift
//  JYVideoProject
//
//  Created by atom on 16/2/15.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

struct video {
    
    let image: String
    
    let title: String
    
    let source: String
}

class VideoCell: UITableViewCell {
    @IBOutlet weak var videoScreenshot: UIImageView!

    @IBOutlet weak var videoTtitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
