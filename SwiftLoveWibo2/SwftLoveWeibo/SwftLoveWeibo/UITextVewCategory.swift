//
//  UITextVewCategory.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/28.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UITextView {

    func insetEmoticonImage(emoticon: Emoticon) {
        
        if emoticon.isRemove {
        
            deleteBackward()
            
            return
            
        }
        
        if emoticon.imageStr != nil {
            
            self.replaceRange(self.selectedTextRange!, withText: emoticon.imageStr!)
            
        }
        
        if emoticon.png != nil {
                
                let imageText = EmoticonTextAttachment.imageText(emoticon, font: font!)
                
                let strM = NSMutableAttributedString(attributedString: attributedText)
                
                let range = self.selectedRange
                
                strM.replaceCharactersInRange(range, withAttributedString: imageText)
            
                self.attributedText = strM
                
                self.selectedRange = NSMakeRange(range.location + 1, 0)
            
        }
        
        
    
    }
    
    func emoticonAttributesText() -> String {
    
        var strM = String()
        
        attributedText.enumerateAttributesInRange(NSMakeRange(0, attributedText.length), options: NSAttributedStringEnumerationOptions(rawValue: 0), usingBlock: { (objc, range, _) -> Void in

            if objc["NSAttachment"] != nil {
                
                let attrachment = objc["NSAttachment"] as! EmoticonTextAttachment
                
                strM += attrachment.chs!
            
                
            } else {
                
                strM += (self.text as NSString).substringWithRange(range)
            
            }
        })
        
        return strM
    }
    
    

}
