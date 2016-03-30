//
//  EmoticonTextAttachment.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class EmoticonTextAttachment: NSTextAttachment {
    
    var chs: String?
    
    class func imageText(emoticon: Emoticon, font: UIFont) -> NSAttributedString {
        
        let attachment = EmoticonTextAttachment()
        
        attachment.image = UIImage(named: emoticon.imagePath!)
        
        attachment.chs = emoticon.chs!
        
        let width = font.lineHeight
        
        attachment.bounds = CGRect(x: 0, y: -4, width: width, height: width)
        
        let mageText = NSAttributedString(attachment: attachment)
        
        let strM = NSMutableAttributedString(attributedString: mageText)
        
        
        strM.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, 1))
        
        return strM
    
    }

}
