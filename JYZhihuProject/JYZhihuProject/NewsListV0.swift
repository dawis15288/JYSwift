//
//  NewsListV0.swift
//  JYZhihuProject
//
//  Created by atom on 16/2/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation


class NewsVO {
    
    let images: [String]?
    
    let title: String
    
    let type: Int = 0
    
    let id: Int
    
    let gaPrefix: Int?
    
    let mutipic: Bool
    
    var alradyRead = false
    
    init(id: Int, title: String, images: [String]? = nil , multipic: Bool? = false, gaPrefix: Int? = nil) {
        
        self.id = id
        
        self.title = title
        
        self.images = images
        
        self.mutipic = mutipic ?? false
        
        self.gaPrefix = gaPrefix
    
    }

}


class NewsListVO {
    
    var date: Int!
    
    var topNews: [NewsVO]?
    
    var news: [NewsVO]?
    
    init() {
    
    
    }
    
    init(date: Int, news: [NewsVO]?, topNews: [NewsVO]) {
    
        self.date = date
        
        self.topNews = topNews
        
        self.news = news
    }
}