//
//  JYTopics.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/27.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

extension Alamofire.Request {
    
    class func imageResponseSerializer() -> ResponseSerializer<UIImage?, NSError> {
    
        return ResponseSerializer { request, response, data, error in
            
            guard error == nil else { return .Failure(error!)}
            
            guard let validData = data else {
                
                let failureReason = "数据无法被序列化，因为接收到的数据为空"
                
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                
                return .Failure(error)
            
            }
        
            let image = UIImage(data: validData, scale: UIScreen.mainScreen().scale)
            
            return .Success(image)
        
        }
            
            
        
    }


    public func responseImage(completionHandler: Response<UIImage?, NSError> -> Void ) -> Self {
    
    
        return response(responseSerializer: Request.imageResponseSerializer(), completionHandler: completionHandler)
    }

}

class JYTopics: NSObject {
    
    var maxid: String?	//string	最大的帖子id
    var maxID: String?	//int	帖子的总数
    var page: String?	//int	默认情况下，就是一页20个帖子情况下的最大页数
    var maxtime: String?	//string	每次加载下一页的时候，需要传入上一页返回参数中对应的此内容，例如：1434112682
    var love: String?	//string	收藏量
    var cai: String?	//string	踩的人数
    var type: Int = 0	//int	帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
    var theme_ID: String?	//string	标签的id,如：微视频的id为55
    var theme_name: String?	//string	帖子的所属分类的标签名字
    var profile_image: String?	//string	头像的图片url地址
    var screen_name: String?	//string	发帖人的昵称
    var from: String?	//string	9
    var hate: String?	//string	踩的数量
    var id: Int = 0	//int	帖子id
    var text: String?	//string	帖子的内容
    var tag: String?	//string	帖子的标签备注
    var height: String?	//string	图片或视频等其他的内容的高度
    var repost: String?	//string	转发的数量
    var favourite: String?	//string	帖子的收藏量
    var bookmark: String?	//string	帖子的收藏量
    var user_id: String?	//string	发帖人的id
    var name: String?	//string	发帖人的昵称
    var width: String?	//string	视频或图片类型帖子的宽度
    var comment: String?	//string	帖子的被评论数量
    var status: String?	//string	帖子的状态（例：4）
    
    var created_at: String?
    
    
    init(dict: [String: AnyObject]) {
        
        super.init()
        
        self.maxid = dict["maxid"] as? String
        
        self.maxID = dict["maxtime"] as? String
        
        self.page = dict["page"] as? String
        
        self.maxtime = dict["maxtime"] as? String
        
        self.love = dict["love"] as? String
        
        self.text = dict["text"] as? String
        
        self.screen_name = dict["screen_name"] as? String
        
        self.favourite = dict["favourite"] as? String
        
        self.name = dict["name"] as? String
        
        self.profile_image = dict["profile_image"] as? String
        
        self.hate = dict["hate"] as? String
        
        self.repost = dict["repost"] as? String
        
        self.profile_image = dict["profile_image"] as? String
        
        self.favourite = dict["favourite"] as? String
        
        self.comment = dict["comment"] as? String
        
        self.created_at = dict["created_at"] as? String
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func model2Topic(models: [[String: AnyObject]]) -> [JYTopics] {
    
        var jymodels = [JYTopics]()
        
        for model in models {
            
            jymodels.append(JYTopics(dict: model))
        
        
        }
        
        return jymodels
    
    
    }

}
