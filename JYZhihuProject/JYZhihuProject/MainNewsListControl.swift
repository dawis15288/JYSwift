//
//  MainNewsListControl.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

import SwiftyJSON

class MainNewListControl {
    
    var todayNews: NewsListVO?
    
    var news: [NewsListVO] = []
    
    func refreshNews() {
        
        if todayNews == nil {
            
            refreshTodayNews()
            
            return
        
        }
    
    }
    
    private func refreshTodayNews() {
        
        Alamofire.Manager.sharedInstance.request(.GET, LATEST_NEWS_URL, parameters: nil, encoding: ParameterEncoding.URL).responseJSON(options: .MutableContainers, completionHandler: { (response) -> Void in
            
            if let result: AnyObject = response.data {
                
                let json = JSON(result)
                
                let date = Int(json["date"].string!)
                
                let top_stories = json["top_stories"].array
                
                let stories = json["stories"].array
                
                let topNws: [NewsVO]? = self.convertStoriesjson2VO(stories, type: .TOP_NEWS)
                
                let lastesNews: [NewsVO]? = self.convertStoriesjson2VO(stories, type: .NEWS)
                
            }
        
        })
    
    }
    
    private func convertStoriesjson2VO(stories: [JSON]?, type: NewsTypeEnum = .NEWS) -> [NewsVO] {
        
        var news: [NewsVO]? = nil
        
        if let _stories = stories {
            
            news = []
            
            for story in _stories {
                
                let new = self.convertJSON2VO(story, type: type)
                
                news?.append(new)
            
            }
        
        }
        
        return news!
    }
    
    private func convertJSON2VO(json: JSON, type: NewsTypeEnum = .NEWS) -> NewsVO {
        
        let id = json["id"].int!
        
        let title = json["title"].string!
        
        let gaPrefix = json["ga_prefix"].int
        
        var image: [String]? = nil
        
        if type == .TOP_NEWS {
            
            let _image = json["image"].string
            
            if let i = _image {
                
                image = [i]
            }
        
        } else {
        
            let _images = json["images"].array
            
            if let _is = _images {
                
                image = []
                
                for i in _is {
                
                    image?.append(i.string!)
                }
            }
        
        
        }
        
        let mutipic = json["multipic"].bool
        
        return NewsVO(id: id, title: title, images: image, multipic: mutipic, gaPrefix: gaPrefix)
    
    }
    
    private enum NewsTypeEnum {
    
        case TOP_NEWS
        
        case NEWS
    }
    
}
