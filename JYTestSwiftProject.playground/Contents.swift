//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

for var i = 0; i < 5; i++ {

    print("hello\(i)")
}

//Swift 实现了两个数组运算符closed operator 和 half-operator.前者包含数组中得所有值。

for i in 0...4 {
    
    print(i)

}

for i in 0 ..< 5 {

    print(i)
}


//tutorial1.difficulty  的值是1，然而tutorial2.difficulty的值是2.
//在Swift中结构体是值类型，他们的值是复制的而不是引用的。下面的一行代码意思是复制了tutorial1的值并把它赋值给tutorial2：

struct Tutorial {
    
    var difficulty: Int = 1
}

var t1 = Tutorial()

var t2 = t1

t2.difficulty = 2

t1.difficulty

//view1是个变量可以重新赋值给一个新的实例化的UIView对象。使用let你只赋值一次，但是UIView是一个引用类型的类，所以你可以改变view2的属性，

var view1 = UIView()

view1.alpha = 0.4

let view22 = UIView()

view22.alpha = 1

//view22 = view1

let animals = ["fish", "cat", "chicken", "dog"]
//第一个简化的是参数。系统的参数类型推断功能，可以计算出闭包里面参数的类型，所以你不必定义参数的类型：
let sortedAnimals = animals.sort{ (one: String, two: String) -> Bool in

    return one < two
}

let sortAnimals1 = animals.sort{ (one, two) -> Bool in

    return one < two
}

//函数返回值也可以被推断出来，所以简化掉，

let sortAnimals2 = animals.sort{ (one, two) in
    
    print(one)
    
    print(two)

    return one < two
}



//这个$i 符号可以代替参数名字，代码进一步简化为：

let sortAnimals3 = animals.sort{ return $0 < $1 }

print(sortAnimals3)

//在一个独立的闭包内，return这个关键字是可以省略的。最后声明的返回值就是闭包的返回值：

let sortAnimals4 = animals.sort{ $0 < $1 }

print(sortAnimals4)

//func <(lhs: String, rhs: String) -> Bool

let sortAnimals5 = animals.sort(<)

print(sortAnimals5)

class Address {
    
    var fullAddress: String
    
    var city: String
    
    init(fullAddress: String, city: String) {
        
        self.fullAddress = fullAddress
        
        self.city = city
    
    }

}

class Person {
    
    var name: String
    
    var address: Address
    
    init(name: String, address: Address) {
        
        self.name = name
        
        self.address = address
        
    }
}

var hadeequarters = Address(fullAddress: "1223 test swift", city: "apple")

var ray = Person(name: "Ray", address: hadeequarters)

var brian = Person(name: "Brian", address: hadeequarters)

brian.address.fullAddress = "456"

print(ray.address.fullAddress)

/*答案：Ray同样会搬家到新的建筑物里面。Address是一个引用类型类，所以无论你是通过ray或者brain访问headquarters，访问都是同一个实例化对象。headquarters对象的变化也会引起ray和brain的变化。你能想象如果Brain收到Ray的邮件或者相反Ray收到Brain的邮件，将会发生什么？解决方案是创建一个新的Address对象赋值给Brain或者把Address声明成为结构体而不是一个类。*/


//两者没有什么不同。Optional.None（简称.None）是optional变量值初始化的标准方法，而nil只是.None语法的一种修饰。事实上下面语句输出是正确的：

var optional1: String? = nil

var optional2: String? = .None

if nil == .None {
    
    print("tes")

}

public class ThermomenterClass {

    private(set) var temperture: Double = 0.0
    
    public func registrTemprature(temperature: Double) {
    
        self.temperture = temperature
        
    }
}

let thrmomentrCalss = ThermomenterClass()

thrmomentrCalss.registrTemprature(56.0)

public struct ThermomentStruct {
    
    private(set) var temperatur: Double = 0.0
    
    public mutating func registerTemperatur(temperature: Double) {
        
        self.temperatur = temperature
    
    }

}

//代码的最后一行不会被编译通过。ThermometerStruct结构体中正确的声明了一个mutating属性函数，它是用来改变结构体内部temperature属性的值的，但是编译器不通过的原因是，通过let创建的不可变的registerTemperature结构体调用了registerTemperature函数。

//let thermomentStruct = ThermomentStruct()

var thermomentStruct = ThermomentStruct()

thermomentStruct.registerTemperatur(56.00)

var thing = "cars"

let closure = { [thing] in
    
    print("I love \(thing)")

}

let closure1 = {
    
    print("I love \(thing)")
}

thing = "airplanes"

//当闭包被声明的时候，抓捕列表就复制一份thing变量，所以被捕捉的值并没有改变，即使你给thing赋了一个新值。如果你要忽视闭包中捕捉列表的值，那么编译器引用那个值而不是复制。这种情况下，被引用变量的值的变化将会反映到闭包中，正如下面的代码所示：

closure()

closure1()

func countUniques<T: Comparable>(array: Array<T>) -> Int {
    
    let sorted = array.sort(<)
    
    let initial: (T?, Int) = (.None, 0)
    
    let reduced = sorted.reduce(initial) { ( $1, $0.0 == $1 ? $0.1 : $0.1 + 1 )}
    
    return reduced.1
    
}

extension Array where Element: Comparable {
    
    func countUniquesArray() -> Int {
        
        let sorted = sort(<)
        
        let initial: (Element?, Int) = (.None, 0)
        
        let reduced = sorted.reduce(initial) { ( $1, $0.0 == $1 ? $0.1 : $0.1 + 1 )}
        
        return reduced.1
        
    }

}


//在Swift 2.0 中，泛类型可以使用类型约束条件被强制扩展。但是假如这个泛类型不满足这个类型的约束条件，那么这个扩展方法既不可见也无法调用。

countUniques([1, 2, 4, 3])

[1, 2, 4, 3,5].countUniquesArray()

/*

下面一个函数的功能是计算两个double（optional）类型的数的相除的结果。在执行除法之前，必须提前满足三个条件：

被除数必须包含nil值

除数必须为包含nil值

除数不能为零

*/

func divide(divide: Double?, by divisor: Double?) -> Double? {

    /*if divide == .None {
        
        return .None
    
    }*/
    
    //guard divide != .None else { return .None}
    
    /*guard let dividend = divide else { return .None }
    
    guard let divisor = divisor else { return  .None }
    
    guard divisor != 0 else { return .None }*/
    
    guard let dividend = divide, divisor = divisor where divisor != 0 else { return .None }
    
    return dividend / divisor

}

//guard语句是在Swift 2.0中引进的，它是用途是在未满足某个条件时，提供一个退出的路径。对于检查是否满足先决条件来说，它是非常有用的。因为它可以使你更清晰的表达逻辑——而不是像i各种f语句嵌套实现那么复杂

public struct Thermomenter {
    
    public var temperatur: Double
    
    public init(temperature: Double) {
        
        self.temperatur = temperature
    
    }

}


//Swift 定义了下面的协议，这些协议可以使一种类型通过字面量的方式来初始化并赋值。

/*

3
4
5
6
7
8
9
NilLiteralConvertible
BooleanLiteralConvertible
IntegerLiteralConvertible
FloatLiteralConvertible
UnicodeScalarLiteralConvertible
ExtendedGraphemeClusterLiteralConvertible
StringLiteralConvertible
ArrayLiteralConvertible
DictionaryLiteralConvertible
采用相应的协议并且提供一个允许字面量初始化的公用方法。在Thermometer类型的例子下，我们需要实现FloatLiteralConvertible协议，
*/

extension Thermomenter: FloatLiteralConvertible {

    public init(floatLiteral value: FloatLiteralType) {
    
        self.init(temperature: value)
    }
}
var t: Thermomenter = Thermomenter(temperature: 55.3)

//var t1: Thermomenter = 44.3
