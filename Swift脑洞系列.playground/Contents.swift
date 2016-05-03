//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let num = [1,2,3,4]

let res = num.map { $0 + 2 }

print(res)

var smearr: [Int]

smearr = [1,2,3,4]

var reslur = smearr.map { (res) -> String in
    
    return "N.\(res)"
}

print(reslur)


var flatres = smearr.flatMap { (res) -> String in
    
    return "N.\(res)"
    
}

print(flatres)


let numbersCompound = [[1,2,3],[4,5,6]];

var numbersCompound1 = numbersCompound.flatMap{ $0.map { $0 + 2 } }

print(numbersCompound1)

var nums:Int? = 2

var add = nums.map { $0 + 3 }

print(add)

var nilNum:Int? = 3
var addResult = nilNum.map{ $0 }

var value: Double? = 10

var val = value.flatMap{ Int($0) }



func add(num: Int) -> Int{
    return num + 1
}

var optionalNum:Int? = 1

optionalNum.map(add)

let a: Int? = nil
let b: Int?? = a
let c: Int??? = b
let d: Int??? = nil

var dict :[String:String?] = [:]
dict = ["key": "value"]
func justReturnNil() -> String? {
    return nil
}
dict["key"] = justReturnNil()





