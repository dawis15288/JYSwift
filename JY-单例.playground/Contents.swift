//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let someOptional:Int? = 33

if let x = someOptional {
    
    print("someOptional value is \(x)")
}

let y = someOptional ?? 3

print("someOptional value is \(y)")

//新增使用enumeration匹配 也就是枚举匹配方式

if case .Some(let x) = someOptional {

     print("someOptional value is \(x)") //如果为nil 情况 可不会输出东西 因为匹配的是Some!
    
}

//新增使用可选模式匹配

if case let x? = someOptional {
    
    print("someOptional value is \(x)") //不需要对x进行解包之类的东东

}

let arrayptnnts: [Int?] = [nil,1,2,3,nil,5]

for case let number? in arrayptnnts {

    print("Found a \(number)")
}

for case .Some(let number) in arrayptnnts {
    
    print("Found a \(number)")
}
