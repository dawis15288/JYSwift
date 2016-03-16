//
//  UserAccount.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit



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
   
        if let url = NSURL(string: urlString) {
            
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
                                
                                //self.saveAccount()
                                
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
        
        }
        
        
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("accss_token") as? String
        
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    
    
    
    
}


