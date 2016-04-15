//
//  EmoticonPackages.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/26.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class EmoticonPackages: NSObject {
    
    var id: String?
    
    var group_name_cn: String?
    
    var emoticons: [Emoticon]?
    
    //let packageList: [EmoticonPackages] = EmoticonPackages.loadEmoticon()
    
    init(id: String) {
        
        self.id = id
    }
    
    static let packageList: [EmoticonPackages] = EmoticonPackages.loadEmoticon()
    
    private class func loadEmoticon() -> [EmoticonPackages] {
        
        var packages = [EmoticonPackages]()
        
        let emojiEmpty = EmoticonPackages(id: "com.jy.now")
        
        emojiEmpty.group_name_cn = "最近"
        
        emojiEmpty.emoticons = [Emoticon]()
        
        emojiEmpty.appendEmtyEmoticons()
        
        packages.append(emojiEmpty)
    
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        
        let dict = NSDictionary(contentsOfFile: path!)
        
        let dictArray = dict!["packages"] as! [[String: AnyObject]]
        
        
        
        for d in dictArray {
            
            let package = EmoticonPackages(id: d["id"] as! String)
            
            packages.append(package)
            
            package.loadEmotioncs()
            
            package.appendEmtyEmoticons()
        
        }
        
        return packages
    
    }
    
    func loadEmotioncs() {
        
        let dict = NSDictionary(contentsOfFile: infoPath() as String)
        
        group_name_cn = dict!["group_name_cn"] as? String
        
        let dictArray = dict!["emoticons"] as! [[String: AnyObject]]
        
        emoticons = [Emoticon]()
        
        var index = 0
        
        for d in dictArray {
            
            if index == 20 {
                
                emoticons?.append(Emoticon(isRemove: true))
                
                index = 0
            
            }
            
            emoticons?.append(Emoticon(dict: d, id: id!))
            
            index += 1
        
        }
    
    }
    
    //MARK: 往表情数组中添加空表情
    
    func appendEmtyEmoticons() {
        
        let count = (emoticons?.count)! % 21
        
        for _ in count ..< 20 {
            
            emoticons?.append(Emoticon(isRemove: false))
        
        }
        
        emoticons?.append(Emoticon(isRemove: true))
        
    
    }
    //MARK: 添加最近使用的表情到最近组中
    
    func appendEmoticonToNowGroup(emoticon: Emoticon) {
        
        //如果是删除按钮，返回
        
        if emoticon.isRemove {
            
            return
        
        }
        
        //判断是否包含传进来的表情
        
        let contains = emoticons!.contains(emoticon)
        
        if !contains {
            
            //不否包含传进来的表情，首先删除删除按钮
           
            emoticons?.removeLast()
            
            //添加表情
            
            emoticons?.append(emoticon)
            
        }
        
        //按使用次数对数组排序
        
        
        var res = (emoticons?.sort({ (e1, e2) -> Bool in
            
            return e1.times > e2.times
            
        }))
        
        
        //if !contains {
            
            //删除排序后的数组最后一个，保证每组只包含21个表情
        
        
        
        res?.removeLast()
        
        res?.append(Emoticon(isRemove: true))
        
        
           //把删除添加到最后
            
           
            
        //}
        
        //排序后的数组赋值回去
        
        emoticons = res
    
    }
    
    private class func strToEmo(emoticonString: String?) -> Emoticon? {
        
        //let emoticonString = "[喵喵]"
        
        var emos: Emoticon?
        
        for package in EmoticonPackages.packageList {
            
            emos = package.emoticons?.filter({ (e) -> Bool in
                
                return e.chs == emoticonString!
                
            }).last
            
            if emos != nil {
                
                //emos = emo
                
                break
                
            }
        }
        
        return emos
        
    }
    
    class  func stringToEmoticon(str: String?) -> NSAttributedString? {
        
        let strM = NSMutableAttributedString(string: str!)
        
        do {
            
            let pattern = "\\[.*?\\]"
            
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            
            let res = regex.matchesInString(str!, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str!.characters.count))
            
            
           
            var count = res.count
            
            while count > 0 {
                
                count = count - 1
                
                let checkRes = res[count]
                
                let tempStr = (str! as NSString).substringWithRange(checkRes.range)
                
                if let emoticon = strToEmo(tempStr) {
                    
                    let attrText = EmoticonTextAttachment.imageText(emoticon, font: UIFont.systemFontOfSize(18))
                    
                    strM.replaceCharactersInRange(checkRes.range, withAttributedString: attrText)
                }
            }
            
        } catch {
        
            print(error)
        }
        
        return strM
        
    }
    
    
    
    func infoPath() -> String {
    
        let idPath = EmoticonPackages.emticonPath().stringByAppendingPathComponent(id!) as NSString
        
        return idPath.stringByAppendingPathComponent("info.plist")
    }
    
    class func emticonPath() -> NSString {
        
        let bundlePath = NSBundle.mainBundle().bundlePath as NSString
        
        return bundlePath.stringByAppendingPathComponent("Emoticons.bundle")
    
    }

}

class Emoticon: NSObject {
    
    var id: String?
    
    var chs: String?
    
    var png: String? {
    
        didSet {
            
            let path = EmoticonPackages.emticonPath().stringByAppendingPathComponent(id!) as NSString
            
            imagePath = path.stringByAppendingPathComponent(png!)

        }
    }
    
    var code: String? {
        
        didSet {
        
            let scaner = NSScanner(string: code!)
            
            var result: UInt32 = 0
            
            scaner.scanHexInt(&result)
            
            imageStr = "\(Character(UnicodeScalar(result)))"
        }
    
    }
    
    var cht: String?
    
    var gif: String?
    
    var type: String?
    
    var imagePath: String?
    
    var imageStr: String?
    
    var isRemove: Bool = false
    
    var times: Int = 0
    
    init(isRemove: Bool) {
        
        super.init()
        
        self.isRemove = isRemove
    }
    
    init(dict: [String: AnyObject], id: String) {
        
        super.init()
        
        self.id = id
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
