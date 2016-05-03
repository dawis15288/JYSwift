//
//  CYTableViewCell.swift
//  JokeClient-Yin
//
//  Created by atom on 16/1/19.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class CYTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var imageTap: UITapGestureRecognizer!
    
    @IBOutlet weak var contentTF: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var largeImageURL: String = ""
    
    var data: Statues?
    
    @IBAction func shareBtnClicked() {
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
        
        //
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        /*if let cellData = data, content = cellData.content, image = cellData.image, votes = cellData.votes {
            
            print(cellData.id)
            
            if image.characters.count == 0 {
                
                self.pictureView.hidden = true
                
                self.bottomView.setY(self.contentTF.bottom())
                
            } else {
                
                let imageID = "\(cellData.id)"
                
                let prefiximageID = ( imageID as NSString ).substringToIndex(imageID.characters.count - 4)
                
                let imageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/small/\(image)"
                
                self.pictureView.hidden = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(
                    _:)))
                
                self.pictureView.addGestureRecognizer(tap)
                
                self.pictureView.setImage(imageURL, placeHolder: UIImage(named: "avatar.jpg"))
                
                self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/medium/\(image)"
                
                self.pictureView.setY(self.contentTF.bottom() + 5)
                
                self.bottomView.setY(self.pictureView.bottom())
                
            }
            
            let height = content.stringheightWith(17, width: 300)
            
            self.contentTF!.setHeight(height)
            
            self.contentTF!.text = content
            
            self.likeLabel!.text = "顶\(votes.up)"
            
            self.dislikeLabel!.text = "踩\(votes.down)"
            
            self.commentLabel!.text = "评论\(cellData.comments_count)"
            
            if let cellUser = cellData.user {
                
                self.nickLabel.text = cellUser.login
                
                let userID = String(cellUser.id)
                
                let prefixUserID = ( userID as NSString ).substringToIndex( userID.characters.count - 4 )
                
                if let userIcon = cellUser.icon {
                    
                    let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserID)/\(userID)/medium/\(userIcon)"
                    
                    self.avatarView.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
                    
                    
                } else {
                    
                    self.avatarView.image = UIImage(named: "avatar.jpg")
                    
                    self.nickLabel.text = "匿名"
                    
                }
                
                
                
            }
            
            
            
            
        } else {
            
            self.likeLabel!.text = "顶(0)"
            
            self.dislikeLabel!.text = " 踩(0)"
            
        }
        
        
        guard ((self.data) != nil ) else {
        
            return
        }
        
        let user: AnyObject? = self.data["user"]
        
        print("user --> \(user)\n\n\n")
        
        if let users = self.data["user"] {
         
            if let userDict = users as? NSDictionary {
         
                if let nickText = userDict["login"] as? String {
                    
                    self.nickLabel.text = nickText
                
                }
                
                if let icon = userDict["icon"] {
                    
                    let userIcon = icon as! String
                    
                    if let uIds = userDict["id"] as? NSNumber {
                        
                        let userID = uIds.stringValue as NSString
                        
                        let prefixUserID = userID.substringToIndex(userID.length - 4)
                        
                        let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserID)/\(userID)/medium/\(userIcon)"
                        
                        print("userImageURL--->>> \(userImageURL)\n\n\n")
                        
                        self.avatarView.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
                    
                    } else {
                        
                        self.avatarView.image = UIImage(named: "avatar.jpg")
                    
                    }
                
                } else {
                    
                    self.nickLabel.text = "匿名"
                    
                    self.avatarView.image = UIImage(named: "avatar.jpg")
                
                }
            
            }
        
        }
        
        let content = self.data.stringAttributeForkey("content")
        
        let height = content.stringheightWith(17, width: 300)
        
        if let imgSrc = self.data.stringAttributeForkey("image") as? NSString {
            
            if imgSrc.length == 0 {
                
                self.pictureView.hidden = true
                
                self.bottomView.setY(self.contentTF.bottom())
            
            } else {
                
                if let imageID = self.data.stringAttributeForkey("id") as? NSString {
                    
                    let prefiximageID = imageID.substringToIndex(imageID.length - 4)
                    
                    let imageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/small/\(imgSrc)"
                    
                    self.pictureView.hidden = false
                    
                    let tap = UITapGestureRecognizer(target: self, action: "imageViewTapped:")
                    
                    self.pictureView.addGestureRecognizer(tap)
                    
                    self.pictureView.setImage(imageURL, placeHolder: UIImage(named: "avatar.jpg"))
                    
                    self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageID)/\(imageID)/medium/\(imgSrc)"
                    
                    self.pictureView.setY(self.contentTF.bottom() + 5)
                    
                    self.bottomView.setY(self.pictureView.bottom())
                
                }
            
            }
        
        }
        
        
        if let userDictOp: NSDictionary = user as? NSDictionary {
            
            
            self.contentTF!.setHeight(height)
            
            self.contentTF!.text = content
            
            
            
            
            
            let votes: AnyObject! = self.data["votes"]
            
            if votes as! NSObject == NSNull() {
            
                self.likeLabel!.text = "顶(0)"
                
                self.dislikeLabel!.text = " 踩(0)"
            
            } else {
            
                let votesDict = votes as! NSDictionary
                
                let like = votesDict.stringAttributeForkey("up") as String
                
                let dislike = votesDict.stringAttributeForkey("down") as String
                
                self.likeLabel!.text = "顶\(like)"
                
                self.dislikeLabel!.text = "踩\(dislike)"
            
            }
            
            let commentCount = self.data.stringAttributeForkey("comments_count") as String
            
            self.commentLabel!.text = "评论\(commentCount)"
        }*/
        
    }

     class func cellheightByData(data: Statues) -> CGFloat {
        
        var height: CGFloat = 0
        
        if let content = data.content, image = data.image {
            
             height = content.stringheightWith(17, width: 300)
            
            let imgSrc = image as NSString
            
            if imgSrc.length == 0 {
                
                return 59.0 + height + 40.0
                
            }
        
        }
        
        return 59.0 + height + 5.0 + 112.0 + 40.0
        
    }
    
    func imageViewTapped(sender: UITapGestureRecognizer) {
        
        print("imageViewTapped")
        
        NSNotificationCenter.defaultCenter().postNotificationName("imageViewTapped", object: self.largeImageURL)
        
    }
    
    

}