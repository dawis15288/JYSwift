//
//  JYTopicCell.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

class JYTopicCell: UITableViewCell {
    
    var bottomConts: NSLayoutConstraint?
    
    var request: Alamofire.Request?
    
    var topic: JYTopics? {
        
        didSet {
        
            self.name.text = topic!.name
                
            if let createAt = topic!.created_at {
            
                self.dealtime(createAt)
                
                let now = NSDate()
                
                if createAt.isYear() {
                    
                    if createAt.isToday() {
                        
                        let coms = now.equalDate(createAt)
                        
                        print("\(coms)")
                        
                        if coms.hour > 1 {
                            
                           self.time.text = "\(coms.hour)小时前"
                            
                        } else if coms.minute >= 1 {
                            
                           self.time.text = "\(coms.minute)分钟前"
                            
                        } else {
                            
                           self.time.text = "刚刚"
                            
                            
                            
                        }
                        
                        
                    } else if createAt.isYesterday() {
                        
                        let yescreate = createAt.componentsSeparatedByString(" ").last
                        
                         self.time.text = "昨天\(yescreate!)"
                        
                        
                    }
                    
                } else {
                    
                    self.time.text = topic!.created_at
                    
                }
            
            
            }
                
            
            
            
            
            self.contentLabel.text = topic!.text
            
            self.bottomview.topic = topic!
            
            if let imageURL = topic!.profile_image {
                
                
                
                self.imageView?.image = nil
                
                self.request?.cancel()
                
                self.request = Alamofire.request(.GET, imageURL).responseImage({ (response) in
                    
                    guard let image = response.result.value where response.result.error == nil else { return }
                    
                    self.profileImageview.image = image
                    
                })
            
            }
            
            /* BudejieNetTool.loadThememage( topic!.profile_image) { (data, errr) in
             
             if data != nil && errr == nil {
             
             
             self.profileImageview.image = UIImage(data: data!)
             }
             }*/
            
        
        }
    
    }
    
    
    
    private func dealtime(tm1: String?) {
        
        
        let  calendar = NSCalendar.currentCalendar()
        
        let create = NSDateFormatter()
        
        create.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let fromDate = create.dateFromString(tm1!)
        
        let unit = NSCalendarUnit()
        
        let now = NSDate()
        
        let day = calendar.components(unit, fromDate: fromDate!, toDate: now, options: NSCalendarOptions(rawValue: 0))
        
        print("年\(day.year)月\(day.month)日\(day.day)时\(day.hour)分\(day.minute)秒\(day.second)")
    
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIS()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUIS() {
        
        contentView.addSubview(profileImageview)
    
        contentView.addSubview(contentLabel)
        
        contentView.addSubview(name)
        
        contentView.addSubview(time)
        
        contentView.addSubview(bottomview)
        
        let width = UIScreen.mainScreen().bounds.width
        
        profileImageview.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
        name.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: profileImageview, size: nil, offset: CGPoint(x: 10, y: 0))
        
        time.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: profileImageview, size: nil, offset: CGPoint(x: 10, y: -10))
        
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: profileImageview, size: nil, offset: CGPoint(x: 5, y: 10))
        
       // bottomview.xmg_AlignHorizontal(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: width, height: 54), offset: CGPoint(x: 0, y: 10))
        
       let cons =  bottomview.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: width, height: 44), offset: CGPoint(x: -30, y: 10))
        
        //bottomview.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: contentView, size: CGSize(width: width, height: 44), offset: CGPoint(x: 0, y: -10))
        
        self.bottomConts = xmg_Constraint(cons, attribute: NSLayoutAttribute.Top)
    
    }
    
    func getRowHeight(topic: JYTopics) -> CGFloat {
        
        let width = self.frame.size.width
        
        let height = self.frame.size.height
        
        let x = self.frame.origin.x
        
        self.frame = CGRect(x: 5, y: self.frame.origin.y + 10, width: width - x , height: height - 1)
        
        self.topic = topic
    
        self.layoutIfNeeded()
        
        return CGRectGetMaxY(bottomview.frame)
        
    }
    
    private lazy var contentLabel: UILabel = {
    
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(16)
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = self.frame.size.width
        
        return label
    
    }()
    
    private lazy var name: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(13)
        
        return label
    
    }()
    
    private lazy var time: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(11)
        
        return label
        
    }()
    
    
    
    private lazy var profileImageview: UIImageView = {
    
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "defaultUserIcon")
        
        return imageView
    
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        /*let width = self.frame.size.width
        
        let height = self.frame.size.height
        
        let x = self.frame.origin.x
        
        self.frame = CGRect(x: 5, y: self.frame.origin.y, width: width - x , height: height - 1)*/
        
    }
    
    private lazy var bottomview: JYBottomView = JYBottomView()

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
