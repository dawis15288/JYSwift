//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myint = 0

/*extension Int {
  
    func plusOne() -> Int {
        
        return self + 1
    
    }
    

}*/

extension Int {
    
    mutating func plusOne() {
        
        ++self
        
    }
    
    static func random(min min: Int, max: Int) -> Int {
        
        if max < min { return min }
        
        return Int(arc4random_uniform(UInt32((max - min ) + 1))) + min
        
    }
    
    
}


myint.plusOne()

myint = 10

myint.plusOne()

Int.random(min: 9, max: 10)

func RandomInt(minimum min: Int, maximum max: Int) -> Int {
    
    if max < min { return min }
    
    return Int(arc4random_uniform(UInt32((max - min ) + 1))) + min

}

RandomInt(minimum: 8, maximum: 10)

extension UIColor {
    
    static func chartreuseColor() -> UIColor {
        
        return UIColor(red: 0.875, green: 1, blue: 0, alpha: 0.5)
    
    }

}

UIColor.chartreuseColor()
