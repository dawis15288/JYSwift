//
//  JYCommentCell.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/21.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYCommentCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var data: Comments?
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        /*let user: AnyObject! = self.data["user"]
        
        if user as! NSObject != NSNull() {
        
            let userDict = user as! NSDictionary
            
            self.nickLabel.text = userDict["login"] as! NSString as String
            
            let icon: AnyObject! = userDict["icon"]
            
            if icon as! NSObject != NSNull() {
            
                let userIcon = icon as! String
                
                let userID = userDict.stringAttributeForkey("id") as NSString
                let prefixuserID = userID.substringToIndex(3)
                
                let userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixuserID)/\(userID)/thumb/\(userIcon)"
                
                self.avatarView!.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
            } else {
            
                self.avatarView!.image = UIImage(named: "avatar.jpg")
            
            }
            
            let timeStamp = userDict.stringAttributeForkey("created_at")
            
            let date = timeStamp.dateStringFromTimestamp(timeStamp)
            
            self.dateLabel!.text = date
        
        } else {
            
            self.nickLabel!.text = "匿名"
            
            self.avatarView!.image = UIImage(named: "avatar.jpg")
            
            self.dateLabel!.text = ""
        
        }
        
        let content = self.data.stringAttributeForkey("content")
        
        let height = content.stringheightWith(17, width: 300)
        
        self.contentLabel!.setHeight(height)
        
        self.contentLabel!.text = content
        
        self.dateLabel!.setY(self.contentLabel!.bottom())
        
        let floor = self.data.stringAttributeForkey("floor")
        
        self.floorLabel!.text = "\(floor)楼"*/
    }
    
    class func cellHeightByData(data: Comments) -> CGFloat {
        
        var height: CGFloat = 0
        
        if let conten = data.content {
            
           height = conten.stringheightWith(17, width: 300)
        
        }
        
        return 53.0 + height + 24.0
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
