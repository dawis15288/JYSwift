//
//  JYAutoLayout.swift
//  RxSwift
//
//  Created by atom on 16/4/9.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: 用在视图上的自动布局函数
    public func JY_Fill(referView: UIView, insets: UIEdgeInsets = UIEdgeInsetsZero) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var cn = [NSLayoutConstraint]()
        
        let views = ["subView": self]
        
        let hformat = "H:|-\(insets.left)-[subView]-\(insets.right)-|"
        
        cn += NSLayoutConstraint.constraintsWithVisualFormat(hformat, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: views)
        
        let Vformat = "V:|-\(insets.top)-[subView]-\(insets.bottom)-|"
        
        cn += NSLayoutConstraint.constraintsWithVisualFormat(Vformat, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: views)
        
        superview?.addConstraints(cn)
        
        return cn
        
    }
    
    public func JY_AlignInner(type type: JY_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPointZero ) -> [NSLayoutConstraint] {
        
        return jy_AlignLayout(referView, attributes: type.layoutAttributes(true, isVertical: true), size: size, offset: offset)
    
    }
    
    
    public func JY_AlignVertical(type type: JY_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPointZero ) -> [NSLayoutConstraint] {
        
        return jy_AlignLayout(referView, attributes: type.layoutAttributes(false, isVertical: true), size: size, offset: offset)
    
    }
    
    public func JY_AlignHorizontal(type type: JY_AlignType, referView: UIView, size: CGSize?, offset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        
        return referView .jy_AlignLayout(referView, attributes: type.layoutAttributes(false, isVertical: false), size: size, offset: offset)
        
    
    }
    
    public func jy_HorizontalTile(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        
        firstView.JY_AlignInner(type: JY_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top ))
        
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        var preView = firstView
        
        for i in 1..<views.count {
            
            let subView = views[i]
            
            cons += subView.jy_sizeConstraints(firstView)
            
            subView.JY_AlignHorizontal(type: JY_AlignType.TopRight, referView: preView, size: nil, offset: CGPoint(x: insets.left, y: insets.top ))
            
            preView = subView
        
        }
        
        if let lastView = views.last {
        
            cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -insets.right))
        
        }
        
        addConstraints(cons)
        
        return cons
    
    }
    
    public func jy_VerticalTile(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        
        firstView.JY_AlignVertical(type: JY_AlignType.TopRight, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
        
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -insets.right))
        
        var preView = firstView
        
        for i in 1..<views.count {
            
            let subView = views[i]
            
            subView.JY_AlignVertical(type: JY_AlignType.BottomLeft, referView: preView, size: nil, offset: CGPoint(x: 0, y: insets.bottom))
            
            preView = subView
        
        }
        
        if let lastView = views.last {
            
            cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        }
        
        addConstraints(cons)
        
        return cons
    
    }
    
    public func jy_Constraint(constraintsList: [NSLayoutConstraint], attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
    
        for constraints in constraintsList {
            
            if constraints.firstItem as! NSObject == self && constraints.firstAttribute == attribute {
            
                return constraints
            }
        
        }
        
        return nil
    
    }
    
    //MARK: 实现自动布局的内部调用的函数
    
    
    private func jy_AlignLayout(referView: UIView, attributes: JY_LayoutAttributes, size: CGSize?, offset: CGPoint) -> [NSLayoutConstraint] {
    
        translatesAutoresizingMaskIntoConstraints = false
        
        var cn = [NSLayoutConstraint]()
        
        cn += jy_positionConstraints(referView, attributes: attributes, offset: offset)
        
        if  let size = size {
            
            cn += jy_sizeConstraints(size)
        
        }
        
        superview?.addConstraints(cn)
        
        return cn
    }
    
    private func jy_sizeConstraints(size: CGSize) -> [NSLayoutConstraint] {
        
        var cn = [NSLayoutConstraint]()
        
        cn.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: size.width))
        
        cn.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: size.height))
        
        return cn
    
    }
    
    private func jy_sizeConstraints(referView: UIView) -> [NSLayoutConstraint] {
    
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: referView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: referView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        
        return cons
    }
    
    private func jy_positionConstraints(referView: UIView, attributes: JY_LayoutAttributes, offset: CGPoint) -> [NSLayoutConstraint] {
        
        var cn = [NSLayoutConstraint]()
        
        cn.append(NSLayoutConstraint(item: self, attribute: attributes.horizontal, relatedBy: NSLayoutRelation.Equal, toItem: referView, attribute: attributes.referHorizontal, multiplier: 1.0, constant: offset.x))
        
        cn.append(NSLayoutConstraint(item: self, attribute: attributes.vertical, relatedBy: NSLayoutRelation.Equal, toItem: referView, attribute: attributes.referVertical, multiplier: 1.0, constant: offset.y))
        
        return cn
    }


}
//MARK: 根据视图方位 设置和其他视图的方位关系

public enum JY_AlignType {
    
    case TopLeft
    
    case TopRight
    
    case TopCenter
    
    case BottomLeft
    
    case BottomRight
    
    case BottomCenter
    
    case CenterLeft
    
    case CenterRight
    
    case Center
    
    private func layoutAttributes(isInner: Bool, isVertical: Bool) -> JY_LayoutAttributes {
        
        let attributes = JY_LayoutAttributes()
        
        switch  self {
            
        case .TopLeft:
            
            attributes.horizontals(.Left, to: .Left).verticals(.Top, to: .Top)
            
            if isInner {
                
                return attributes
                
            } else if isVertical {
                
                return attributes.verticals(.Bottom, to: .Top)
                
            } else {
                
                return attributes.horizontals(.Right, to: .Left)
                
            }
            
        case .TopRight:
            
            attributes.horizontals(.Right, to: .Right).verticals(.Top, to: .Top)
            
            if isInner {
                
                return attributes
                
            } else if isVertical {
                
                attributes.verticals(.Bottom, to: .Top)
                
            } else {
                
                attributes.horizontals(.Left, to: .Right)
                
            }
            
        case .BottomLeft :
            
            attributes.horizontals(.Left, to: .Left).verticals(.Bottom, to: .Bottom)
            
            if isInner {
                
                return attributes
                
            } else if isVertical {
                
                attributes.verticals(.Top, to: .Bottom)
                
            } else {
                
                attributes.horizontals(.Right, to: .Left)
                
            }
            
        case .BottomRight:
            
            attributes.horizontals(.Right, to: .Right).verticals(.Bottom, to: .Bottom)
            
            if isInner {
                
                return attributes
                
            } else if isVertical {
                
                attributes.verticals(.Top, to: .Bottom)
                
            } else {
                
                attributes.horizontals(.Left, to: .Right)
                
            }
            
        case .TopCenter:
            
            attributes.horizontals(.CenterX, to: .CenterX).verticals(.Top, to: .Top)
            
            return isInner ? attributes : attributes.verticals(.Bottom, to: .Top)
            
        case .BottomCenter:
            
            attributes.horizontals(.CenterX, to: .CenterX).horizontals(.Bottom, to: .Bottom)
            
            return isInner ? attributes : attributes.verticals(.Top, to: .Bottom)
            
        case .CenterLeft:
            
            attributes.horizontals(.Left, to: .Left).horizontals(.CenterY, to: .CenterY)
            
            return isInner ? attributes: attributes.horizontals(.Right, to: .Left)
            
        case .CenterRight:
            
            attributes.horizontals(.Right, to: .Right).verticals(.CenterY, to: .CenterY)
            
            return isInner ? attributes : attributes.verticals(.Left, to: .Right)
            
        case.Center:
            
            return JY_LayoutAttributes(horizontal: .CenterX, referHorizontal: .CenterX, vertical: .CenterY, referVertical: .CenterY)
            
        }
    
        return attributes
    }
        
       
}


//MARK: 记录传进来的视图的相对方位关系

private final class JY_LayoutAttributes {

    var horizontal: NSLayoutAttribute
    
    var referHorizontal: NSLayoutAttribute
    
    var vertical: NSLayoutAttribute
    
    var referVertical: NSLayoutAttribute
    
    init() {
        
        self.horizontal = NSLayoutAttribute.Left
        
        self.referHorizontal = NSLayoutAttribute.Left
        
        self.vertical = NSLayoutAttribute.Top
        
        self.referVertical = NSLayoutAttribute.Top
        
    }
    
    init(horizontal: NSLayoutAttribute, referHorizontal: NSLayoutAttribute, vertical: NSLayoutAttribute, referVertical: NSLayoutAttribute) {
        
        self.horizontal = horizontal
        
        self.referHorizontal = referHorizontal
        
        self.vertical = vertical
        
        self.referVertical = referVertical
        
    }
    
    private func horizontals(from: NSLayoutAttribute, to: NSLayoutAttribute) -> Self {
        
        horizontal = from
        
        referHorizontal = to
        
        return self
    
    }
    
    private func verticals(from: NSLayoutAttribute, to: NSLayoutAttribute) -> Self {
    
        vertical = from
        
        referVertical = to
        
        return self
    }

}
