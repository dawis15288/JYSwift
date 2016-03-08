//
//  UIView+AutoLayout.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/2/8.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

public enum JY_AlignType {
    
    case TopLeft
    
    case TopRight
    
    case TopCenter
    
    case BottmLeft
    
    case BottmRight
    
    case BottomCenter
    
    case CenterLeft
    
    case CenterRight
    
    case Center
    
    private func layoutAttributes(isInner: Bool, isVertical: Bool) -> JY_LayoutAttributes {
        
        let attributes = JY_LayoutAttributes()
        
        switch self {
        
        case .TopLeft:
            
            attributes.horiizontals(.Left, to: .Left).verticals(.Top, to: .Top)
            
            if isInner {
                
                return attributes
            
            } else if isVertical {
                
                return attributes.verticals(.Bottom, to: .Top)
            
            } else {
                
                return attributes.horiizontals(.Right, to: .Left)
            
            }
            
        case .TopRight:
            
            attributes.horiizontals(.Right, to: .Right).verticals(.Top, to: .Top)
            
            if isInner {
                
                return attributes
            
            } else if isVertical {
                
                return attributes.verticals(.Bottom, to: .Top)
            
            } else {
            
                return attributes.horiizontals(.Left, to: .Right)
                
                
            }
            
        case .BottmLeft:
            
            attributes.horiizontals(.Left, to: .Left).verticals(.Bottom, to: .Bottom)
            
            if isInner {
                
                return attributes
            
            } else if isVertical {
            
                return attributes.verticals(.Top, to: .Bottom)
                
            } else {
            
                return attributes.horiizontals(.Right, to: .Left)
            }
            
        case .BottmRight:
            
            attributes.horiizontals(.Right, to: .Right).verticals(.Bottom, to: .Bottom)
            
            if isInner {
                
                return attributes
            
            } else if isVertical {
                
                return attributes.verticals(.Top, to: .Bottom)
            
            } else {
                
                return attributes.horiizontals(.Left, to: .Right)
            
            }
            
        case .TopCenter:
            
            attributes.horiizontals(.CenterX, to: .CenterX).verticals(.Top, to: .Top)
            
            return isInner ? attributes : attributes.verticals(.Bottom, to: .Top)
            
        case .BottomCenter:
            
            attributes.horiizontals(.CenterX, to: .CenterX).verticals(.Bottom, to: .Bottom)
            
            return isInner ? attributes : attributes.verticals(.Bottom, to: .Bottom)
            
        case .CenterLeft:
            
            attributes.horiizontals(.Left, to: .Left).verticals(.CenterY, to: .CenterY)
            
            return isInner ? attributes : attributes.horiizontals(.Right, to: .Left)
            
        case .CenterRight:
            
            attributes.horiizontals(.Right, to: .Right).verticals(.CenterY, to: .CenterY)
            
            return isInner ? attributes : attributes.horiizontals(.Left, to: .Right)
            
        case .Center:
            
            return JY_LayoutAttributes(horizontal: .CenterX
                , referHorizontal: .CenterX, vertical: .CenterY, referVertical: .CenterY)
            
        
        }
    
    }

}

extension UIView {
    
    public func JY_Fill(referView: UIView, insets: UIEdgeInsets = UIEdgeInsetsZero) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(insets.left)-[subView]-\(insets.right)-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": self])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(insets.top)-[subView]-\(insets.bottom)-|", options: .AlignAllBaseline, metrics: nil, views: ["subView": self])
        
        superview?.addConstraints(cons)
        
        return cons
    
    }
    
    public func JY_AlignInner(type type: JY_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        
        return JY_AlignLayout(referView, attributes: type.layoutAttributes(true, isVertical: true), size: size, offset: offset)
    
    }
    
    public func jy_AlignVertical(type type: JY_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        
        return JY_AlignLayout(referView, attributes: type.layoutAttributes(false, isVertical: true), size: size, offset: offset)
    
    }
    
    public func jy_AlignHoruizonl(type type: JY_AlignType, referVuew: UIView, size: CGSize?, offset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        
        return JY_AlignLayout(referVuew, attributes: type.layoutAttributes(false, isVertical: false), size: size, offset: offset)
    
    }
    
    public func jy_HorizontalTitle(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        
        firstView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
        
        cons.append(NSLayoutConstraint(item: firstView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        var preView = firstView
            
            for i in 1 ..< views.count {
                
                let subView = views[i]
                
                cons += subView.jy_sizeConstraints(firstView)
                
                subView.jy_AlignHoruizonl(type: JY_AlignType.TopRight, referVuew: preView, size: nil, offset: CGPoint(x: insets.right, y: 0))
                
                preView = subView
            
            }
        
        let lastView = views.last!
        
        cons.append(NSLayoutConstraint(item: lastView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: -insets.right))
        
        addConstraints(cons)
        
        return cons
    
    }
    
    public func jy_VerticalTitle(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        
        firstView.jy_AlignHoruizonl(type: JY_AlignType.TopLeft, referVuew: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
        
        cons.append(NSLayoutConstraint(item: firstView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: -insets.right))
        
        var preView = firstView
        
        for i in 1 ..< views.count {
            
            let subView = views[i]
            
            cons += subView.jy_sizeConstraints(firstView)
            
            subView.jy_AlignVertical(type: .BottmLeft, referView: preView, size: nil, offset: CGPoint(x: 0, y: insets.bottom))
            
            preView = subView
        
        }
        
        let lastView = views.last!
        
        cons.append(NSLayoutConstraint(item: lastView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        addConstraints(cons)
        
        return cons
    
    }
    
    public func jy_Constraint(constraintsList: [NSLayoutConstraint], attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        
        
        for constraint in constraintsList {
            
            if constraint.firstItem as! NSObject == self && constraint.firstAttribute == attribute {
                
                return constraint
            
            }
        
        }
    
        return nil
        
    }
    
    private func JY_AlignLayout(referView: UIView, attributes: JY_LayoutAttributes, size: CGSize?, offset: CGPoint) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += jy_positionConstraints(referView, attributes: attributes, offset: offset)
        
        if size != nil {
            
            cons += jy_sizeConstraints(size!)
        
        }
        
        superview?.addConstraints(cons)
        
        return cons
    }
    
    private func jy_sizeConstraints(size: CGSize) -> [NSLayoutConstraint] {
        
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: size.width))
        
        cons.append(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size.height))
        
        return cons
    
    }
    
    private func jy_sizeConstraints(referView: UIView) -> [NSLayoutConstraint] {
    
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: referView, attribute: .Width, multiplier: 1.0, constant: 0))
        
        cons.append(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: referView, attribute: .Height, multiplier: 1.0, constant: 0))
        
        return cons
    }
    
    private func jy_positionConstraints(referView: UIView, attributes: JY_LayoutAttributes, offset: CGPoint) -> [NSLayoutConstraint] {
    
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: attributes.horizontal, relatedBy: .Equal, toItem: referView, attribute: attributes.referHorizontal, multiplier: 1.0, constant: offset.x))
        
        cons.append(NSLayoutConstraint(item: self, attribute: attributes.vertical, relatedBy: .Equal, toItem: referView, attribute: attributes.referVertical, multiplier: 1.0, constant: offset.y))
        
        return cons
    }

}

private final class JY_LayoutAttributes {
    
    var horizontal: NSLayoutAttribute
    
    var referHorizontal: NSLayoutAttribute
    
    var vertical: NSLayoutAttribute
    
    var referVertical: NSLayoutAttribute
    
    init() {
        
        horizontal = NSLayoutAttribute.Left
        
        
        referHorizontal = NSLayoutAttribute.Left
        
        vertical = NSLayoutAttribute.Top
        
        referVertical = NSLayoutAttribute.Top
        
        
    }
    
    init(horizontal: NSLayoutAttribute, referHorizontal: NSLayoutAttribute, vertical: NSLayoutAttribute, referVertical: NSLayoutAttribute) {
        
        self.horizontal = horizontal
        
        self.referHorizontal = referHorizontal
        
        self.vertical = vertical
        
        self.referVertical = referVertical
        
    }
    
    private func horiizontals(from: NSLayoutAttribute, to: NSLayoutAttribute) -> JY_LayoutAttributes {
        
        horizontal = from
        
        referHorizontal = to
        
        return self
        
    }
    
    private func verticals(from: NSLayoutAttribute, to: NSLayoutAttribute) -> JY_LayoutAttributes {
        
        vertical = from
        
        referVertical = to
        
        return self
        
    }
    
}
