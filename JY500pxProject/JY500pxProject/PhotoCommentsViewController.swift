//
//  PhotoCommentsViewController.swift
//  JY500pxProject
//
//  Created by atom on 16/5/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

let PhotocommentID = "JYCommentsCell"

class PhotoCommentsViewController: UIViewController {
    
    var photoID: Int = 0
    
    var comments: [Comment]? {
        
        didSet {
            
            self.commentTableview.reloadData()
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismissVC))
        
        self.title = "Comment"

        // Do any additional setup after loading the view.
        
        setupUIS()
        
        Alamofire.request(Five500px.Router.Comments(photoID, 1)).validate().responseCollection { (response: Response<[Comment], NSError>) in
            
            guard response.result.error == nil else { return }
            
            self.comments = response.result.value
            
            self.sipnner.stopAnimating()
            
        }
    }
    
    
    private func setupUIS() {
        
        self.view.addSubview(commentTableview)
        
        self.view.addSubview(sipnner)
        
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        let offset = CGPoint(x: 0, y: 0)
        
        commentTableview.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: size, offset: offset)
    
    }
    
    func dismissVC() {
    
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    private lazy var commentTableview: UITableView = {
        
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.registerClass(PhotoCommentCell.self, forCellReuseIdentifier: PhotocommentID)
        
        tableView.rowHeight = 84.0
        
        return tableView
    
    }()
    
    private lazy var sipnner: UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        indicatorView.center = CGPoint(x: self.view.center.x, y: 84.0)
        
        indicatorView.startAnimating()
        
        indicatorView.color = UIColor.darkGrayColor()
        
        return indicatorView
    
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotoCommentsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PhotocommentID, forIndexPath: indexPath) as! PhotoCommentCell
        
        cell.comment = self.comments![indexPath.row]
        
        return cell
    }

}

class PhotoCommentCell: UITableViewCell {
    
    var request: Alamofire.Request?
    
    var comment: Comment? {
        
        didSet {
        
            self.userFullnameLabel.text = comment!.userFullname
            
            self.commentLabel.text = comment!.commentBody
            
            if let imageURL = comment?.userPictureURL {
            
                self.userImageView.image = nil
                
                self.request?.cancel()
                
                Alamofire.request(.GET, imageURL).validate().responseImage({ (response) in
                    
                    if response.result.error == nil {
                    
                        if response.request?.URLString == imageURL {
                        
                            self.userImageView.image = response.result.value!
                        }
                    }
                })
            }
        }
    
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIS()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIS() {
        
        self.contentView.addSubview(userImageView)
        
        self.contentView.addSubview(commentLabel)
        
        self.contentView.addSubview(userFullnameLabel)
        
        let imageSize = CGSize(width: 30, height: 30)
        
        let imageOffSet = CGPoint(x: 10, y: 10)
        
        userImageView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.contentView, size: imageSize, offset: imageOffSet)
        
        commentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: userImageView, size: nil, offset: CGPoint(x: 10, y: 10))
        
        userFullnameLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: userImageView, size: nil, offset: CGPoint(x: 10, y: 0))
    
    }
    
    private lazy var userImageView: UIImageView = {
    
        let imageview = UIImageView()
        
        imageview.layer.cornerRadius = 5.0
        
        imageview.layer.masksToBounds = true
        
        
        return imageview
    }()
    
    private lazy var commentLabel: UILabel = {
    
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(15)
        
        return label
    
    }()
    
    private lazy var userFullnameLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(13)
        
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = self.contentView.frame.width
        
        
        
        return label
        
    }()

}
