//
//  JYLabel.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/4/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class JYLabel: UILabel {
    
    override var text: String? {
        
        didSet {
            
            if let  attrText = EmoticonPackages.stringToEmoticon(text!) {
                
                //self.attributedText = attrText
                
                textStorage.setAttributedString(attrText)
                
            }
            //textStorage.setAttributedString(NSAttributedString(string: text!))
            
            URLRegex()
            
            setNeedsDisplay()
        
        }
    
    }
    
    override func drawTextInRect(rect: CGRect) {
        
        let range = NSMakeRange(0, textStorage.length)
        
        let rect = layoutManager.boundingRectForGlyphRange(range, inTextContainer: textContainer)
        
        let heght = (bounds.height - rect.height) * 0.5
        
        let offset = CGPoint(x: 0, y: heght)
        
        layoutManager.drawBackgroundForGlyphRange(range, atPoint: offset)
        
        layoutManager.drawGlyphsForGlyphRange(range, atPoint: CGPointZero)
        
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupTextkit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
        
        setupTextkit()
    }
    
    func createJYLabel(color: UIColor, font: CGFloat) -> JYLabel {
        
        let lb = JYLabel()
        
        lb.textColor = color
        
        lb.font = UIFont.systemFontOfSize(font)
        
        return lb
    }
    
    private func setupTextkit() {
        
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.addTextContainer(textContainer)
        
    
    }
    
    private func URLRegex() {
    
        do {
            
            let dataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingType.Link.rawValue))
            
            let res = dataDetector.matchesInString(textStorage.string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, textStorage.string.characters.count))
            
            for checkingRes in res {
                
                let str = (textStorage.string as NSString).substringWithRange(checkingRes.range)
                
                let tempStr = NSMutableAttributedString(string: str)
                
                tempStr.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(18), NSForegroundColorAttributeName: UIColor.redColor()], range: NSMakeRange(0, str.characters.count))
            
                let paragraphStyle = NSMutableParagraphStyle()
                
                paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
                
                tempStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.characters.count))
                
                textStorage.replaceCharactersInRange(checkingRes.range, withAttributedString: tempStr)
            
            }
        
        } catch {}
    
    }

    private lazy var textStorage = NSTextStorage()
    
    private lazy var layoutManager = NSLayoutManager()
    
    private lazy var textContainer = NSTextContainer()
    
    
    
    
    

}
