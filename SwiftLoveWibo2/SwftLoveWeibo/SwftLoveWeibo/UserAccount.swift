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
    
    func loadUserInfo(compeletionhandler:(account: UserAccount?, error: NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json?access_token=\(access_token!)&uid=\(uid!)"
        
       // let params = ["access_token": access_token!, "uid": uid!]
        
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
                                
                                self.saveAccount()
                                
                                compeletionhandler(account: self, error: nil)
                                
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
    
    static let accountPath = "accound.plist".cacheDir()
    
    func saveAccount() {
        
    
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
    }
    ///Users/atom/Library/Developer/CoreSimulator/Devices/39AD07D7-51EA-476E-9916-0B1CC7C05133/data/Containers/Data/Application/1B91C4E0-5C57-4B00-80AC-A5F3BBCAA695/Documents
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

extension String {
    
    func cacheDir() -> String {
    
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        
        print(path)
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }

}
