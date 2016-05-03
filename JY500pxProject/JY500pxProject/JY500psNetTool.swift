//
//  JY500psNetTool.swift
//  JY500pxProject
//
//  Created by atom on 16/4/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import Foundation

import Alamofire

class JY500psNetTool {
    
    enum ImageSize {
        case Size
    }
    
    /*enum Router: URLRequestConvertible {
        
        static let baseURLString = "https://api.500px.com/v1"
        
        static let consumerKey = "T3QPZUDorA7uFM8Jqp91tzuJzDAY4mmVgaibioZs"
        
        case PopularPhotos(Int)
        
        case PhotoInfo(Int, ImageSize)
        
        case Comments(Int, Int)
        
        
    }*/
    
    
    class func loadPhotoInfo(page: Int?, completsHandler: (photoInfo: [PhotoInfo]?, error: NSError?) -> Void) {
        
       
        
        
        
        
        
        
        
        /*Alamofire.request(.GET, url! , parameters: ["consumer_key": "T3QPZUDorA7uFM8Jqp91tzuJzDAY4mmVgaibioZs"]).responseJSON() {
            response in
            
            if response.result.isSuccess {
                
                let jsonData = response.result.value
                
                let photoJSON = jsonData?.valueForKey("photos") as? [[String: AnyObject]]
                
                var photos = [PhotoInfo]()
                
                photoJSON?.forEach({
                    
                    guard let nsfw = $0["nsfw"] as? Bool,
                    
                    let id = $0["id"] as? Int,
                    
                    let url = $0["image_url"] as? String
                    
                        where nsfw == false else { return print("somthing is error?")}
                    
                    photos.append(PhotoInfo(id: id, url: url))
                    
                })
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    
                    completsHandler(photoInfo: photos, error: nil)
                    
                })
                
                
                
            } else {
                
               completsHandler(photoInfo: nil, error: response.result.error)
            }
            
        }*/
    
    
    }
    
    class func loadImage(url: String?, completsHandler: (photo: NSData?, error: NSError?) -> Void) {
    
        Alamofire.request(.GET, url!).responseData { (response) in
            
            if response.result.isSuccess {
            
                dispatch_async(dispatch_get_main_queue(), {
                    
                    completsHandler(photo: response.result.value, error: nil)
                })
                
            } else {
            
                completsHandler(photo: nil, error: response.result.error)
            }
        }
    }
}