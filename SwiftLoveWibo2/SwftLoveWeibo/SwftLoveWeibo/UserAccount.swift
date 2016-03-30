//
//  UserAccount.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

class UserAccount: NSObject, NSCoding {
    
    var access_token: String?
    
    var expires_Date: NSDate?
    
    var expires_in: NSNumber? {
        
        didSet {
        
            expires_Date = NSDate(timeIntervalSinceNow: (expires_in?.doubleValue)!)
            
            print("过期时间\(expires_Date)")
        
        }
    
    }
    
    
    
    var uid: String?
    
    var name: String?
    
    var avatar_large: String?
    
    var location: String?
    
    var userDescription: String?
    
    var url: String?
    
    var profile_image_url: String?
    
    var cover_image: String?
    
    var cover_image_phone: String?
    
    var gender: String?
    
    var followers_count: NSNumber?
    
    var friends_count: NSNumber?
    
    var pagefriends_count: NSNumber?
    
    var statuses_count: NSNumber?
    
    var favourites_count: NSNumber?
    
    var created_at: String?
    
    var avatar_hd: String?
    
    let proprties = ["accss_token", "expires_in", "uid"]
    
    init(dict: [String: AnyObject]) {
        
        
        
        /*self.access_token = dict["access_token"] as? String
        
        self.expires_in = dict["expires_in"] as? NSNumber
        
        self.uid = dict["uid"] as? String*/
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    func loadUserInfo(compeletionhandler: (account: UserAccount?, error: NSError?) -> Void) {
        
        let urlString = "https://api.weibo.com/2/users/show.json?access_token=\(access_token!)&uid=\(uid!)"
        
        Alamofire.request(.GET, urlString).responseJSON(completionHandler: { (response) -> Void in
        
            if response.result.isSuccess {
                
                if  let dataDict = response.result.value {
                    
                    self.name = dataDict["name"] as? String
                    
                    self.avatar_large = dataDict["avatar_large"] as? String
                    
                    self.userDescription = dataDict["description"] as? String
                    
                    self.cover_image = dataDict["cover_image"] as? String
                    
                    self.cover_image_phone = dataDict["cover_image_phone"] as? String
                    
                    self.gender = dataDict["gender"] as? String
                    
                    self.followers_count = dataDict["followers_count"] as? NSNumber
                    
                    self.friends_count = dataDict["friends_count"] as? NSNumber
                    
                    self.statuses_count = dataDict["statuses_count"] as? NSNumber
                    
                    self.favourites_count = dataDict["favourites_count"] as? NSNumber
                    
                    self.created_at = dataDict["created_at"] as? String
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.name, forKey: "userName")
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.avatar_large, forKey: "userAvatar_large")
                    
                    compeletionhandler(account: self, error: nil)
                    
                }
            
            
            }
        })
   
        /*if let url = NSURL(string: urlString) {
            
            let request = NSURLRequest(URL: url)
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
                if response != nil {
                
                    if (response as! NSHTTPURLResponse).statusCode == 200 {
                    
                        if let data = data {
                        
                            do {
                                
                                let dataDict = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                                
                                    self.name = dataDict["name"] as? String
                                
                                    self.avatar_large = dataDict["avatar_large"] as? String
                                
                                    self.userDescription = dataDict["description"] as? String
                                
                                    self.cover_image = dataDict["cover_image"] as? String
                                
                                    self.cover_image_phone = dataDict["cover_image_phone"] as? String

                                    self.gender = dataDict["gender"] as? String
                                
                                    self.followers_count = dataDict["followers_count"] as? NSNumber
                                
                                    self.friends_count = dataDict["friends_count"] as? NSNumber

                                    self.statuses_count = dataDict["statuses_count"] as? NSNumber
                                
                                    self.favourites_count = dataDict["favourites_count"] as? NSNumber
                                    
                                    self.created_at = dataDict["created_at"] as? String
                                
                                

            
                                NSUserDefaults.standardUserDefaults().setObject(self.name, forKey: "userName")
                                
                                NSUserDefaults.standardUserDefaults().setObject(self.avatar_large, forKey: "userAvatar_large")
                                
                                compeletionhandler(account: self, error: nil)
                                
                                //return
                                
                            } catch _ {}
                        }
                    }
                }
            
            })
            
            task.resume()
        
        }*/
        
        
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func userLogin() -> Bool {
        
        
    
        return loadAccount() != nil
    }
    
    //static let accountpath = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("accound.plist")
    
    static let accountPath = "account.plist".cacheDir()
    
    func saveAccount() {
        
    
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
    }
    
    
    static var account: UserAccount?
    
    class func loadAccount() -> UserAccount? {
        
        if let date = account?.expires_Date where (date.compare(NSDate()) == NSComparisonResult.OrderedAscending) {
            
            account = nil
        
        }
        
        if account != nil {
            
            
            
            return account
        
        }
        
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.accountPath) as? UserAccount
        
        return account
    
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(access_token, forKey: "accss_token")
        
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        
        aCoder.encodeObject(uid, forKey: "uid")
        
        //应为没有归档，所以不能加载到用户的信息
        
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
        aCoder.encodeObject(name, forKey: "name")
        
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        
        aCoder.encodeObject(userDescription, forKey: "userDescription")
        
        aCoder.encodeObject(cover_image, forKey: "cover_image")
        
        aCoder.encodeObject(cover_image_phone, forKey: "cover_image_phone")
        
        aCoder.encodeObject(gender, forKey: "gender")
        
        aCoder.encodeObject(followers_count, forKey: "followers_count")
        
        aCoder.encodeObject(friends_count, forKey: "friends_count")
        
        aCoder.encodeObject(statuses_count, forKey: "statuses_count")
        
        aCoder.encodeObject(favourites_count, forKey: "favourites_count")
        
        aCoder.encodeObject(created_at, forKey: "created_at")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("accss_token") as? String
        
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        
        uid = aDecoder.decodeObjectForKey("uid") as? String
        
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
        name = aDecoder.decodeObjectForKey("name") as? String
        
        expires_Date = aDecoder.decodeObjectForKey("expires_in") as? NSDate
        
        userDescription = aDecoder.decodeObjectForKey("userDescription") as? String
        
        cover_image = aDecoder.decodeObjectForKey("cover_image") as? String
        
        cover_image_phone = aDecoder.decodeObjectForKey("cover_image_phone") as? String
        
        gender = aDecoder.decodeObjectForKey("gender") as? String
        
        followers_count = aDecoder.decodeObjectForKey("followers_count") as? NSNumber
        
        friends_count = aDecoder.decodeObjectForKey("friends_count") as? NSNumber
        
        statuses_count = aDecoder.decodeObjectForKey("statuses_count") as? NSNumber
        
        favourites_count = aDecoder.decodeObjectForKey("favourites_count") as? NSNumber
        
        created_at = aDecoder.decodeObjectForKey("created_at") as? String
        
        
    }
    
    
    
    
}


