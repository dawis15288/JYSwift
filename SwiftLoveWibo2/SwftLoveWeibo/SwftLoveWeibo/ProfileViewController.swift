//
//  ProfileViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/6.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        check("1053065667")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 1.创建正则表达式对象
    /*
    Pattern: 匹配字符串的规则
    options :附加选项
    error: 错误信息
    */
    /**
    NSRegularExpressionCaseInsensitive             = 1 << 0,     忽略大小写
    NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,     忽略空白字符，以及前缀是 # 开始的注释
    NSRegularExpressionIgnoreMetacharacters        = 1 << 2,     将整个匹配方案作为文字字符串
    NSRegularExpressionDotMatchesLineSeparators    = 1 << 3,     允许 . 匹配任意字符，包括回车换行
    NSRegularExpressionAnchorsMatchLines           = 1 << 4,     允许 ^ 和 $ 匹配多行文本的开始和结尾
    NSRegularExpressionUseUnixLineSeparators       = 1 << 5,     仅将 \n 作为换行符
    NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6      使用 Unicode TR#29 指定单词边界
    */
    
    private func check(somgthing: String) -> Bool {
        
        do {
            
            let pattrn = "[1-9][0-9]{4,14}"
            
            
            
            let regex = try NSRegularExpression(pattern: pattrn, options: .CaseInsensitive)
            
            let array = regex.matchesInString(somgthing, options: NSMatchingOptions.init(rawValue: 0), range: NSMakeRange(0, somgthing.characters.count))
            
            for chckngRs in array {
                
                print(chckngRs)
                
            }
            
            let number = regex.numberOfMatchesInString(somgthing, options: NSMatchingOptions.init(rawValue: 0), range: NSMakeRange(0, somgthing.characters.count))
            
            if number == 0 {
                
                return false
            }
            
            
        
        } catch _ {}
        
        return false
    
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
