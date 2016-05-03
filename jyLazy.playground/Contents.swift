//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension UIImage {

    func resizeTo(size: CGSize) -> UIImage {
        
        return self
    
    }
}


class Avatar {
    
    static let defaultSamllSize = CGSize(width: 64, height: 64)
    
    var largeImage: UIImage
    
    lazy var smallImage: UIImage = {
        
        let size = CGSize(
            
            width: min(Avatar.defaultSamllSize.width, self.largeImage.size.width),
                         
            height: min(Avatar.defaultSamllSize.height, self.largeImage.size.height)
        )
        
        return self.self.largeImage.resizeTo(size)
    
    }()
    
    //self.largeImage.resizeTo(Avatar.defaultSamllSize)
    
    init(largeImage: UIImage) {
        
        self.largeImage = largeImage
    
    }
    
    

}

func increment(x: Int) -> Int {
    
    print("Computing next value of \(x)")
    
    return x + 1

}

func double(x: Int) -> Int {
    
    print("Computing next value of \(x)")
    
    return 2 * x

}

let array = Array(0..<1000)

let incArray = array.map(increment)

let incArra = array.lazy.map(increment)
    
let doubleArray = array.lazy.map(increment).map(double)

let doubleArray01 = array.map(increment).map(double)

print("Reult:")

print(incArray[0], incArray[4])

print(incArra[0], incArra[55])

print(doubleArray[3])


enum Direction {
    
    case North, South, East, West
}

extension Direction: CustomStringConvertible {

    var description: String {
        
        switch self {
            case .North:  return "shang"
            
            case .South: return "xia"
            
            case .West: return "you"
            
            case .East: return "zuo"
    
        }
        
    }
}

enum Media {
    
    case Book(title: String, author: String, year: Int)
    
    case Move(title: String, director: String, year: Int)
    
    case WebSite(url: NSURL, title: String)
}

extension Media {
    
    var mediaTtle: String {
        
        switch self {
            case .Book(title:  let aTitle, author: _, year: _): return aTitle
        
            case .Move(title: let aTitle, director: _, year: _): return aTitle
            
            case .WebSite(url: _, title: let aTitle): return aTitle
        
        }
        
    }

}



extension Media {
    
    var isFromJulesVerne: Bool {
        
        switch self {
            
            case .Book(title: _, author: "Jules Verne", year: _): return true
            
            case .Move(title: _, director: "Jules Verne", year: _): return true
            
            default: return false
        
        }
    
    }

}

extension Media {
    
    func checkAuthor(author: String) -> Bool {
        
        switch self {
        case .Book(title: _, author: author, year: _): return true
            
        case .Move(title: _, director: author, year: _): return true
            
        default:
            return false
        }
    }

}

extension Media {
    
    var publicshedAfter1930: Bool {
        
        switch self {
        case let .Book(_,_,year) where year > 1930: return true
            
        case let .Move(_,_,year) where year > 1930: return true
            
        case .WebSite: return true
            
        default:
            return false
        }
    
    }

}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)

book.mediaTtle

book.isFromJulesVerne

book.checkAuthor("Jules Verne")

class Person: NSObject {
    
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        
        return ""
        
    }
    
}

let peter = Person(firstName: "Cook", lastName: "Peter")

print(peter.lastName)
print(peter.valueForKey("lastName")!)

let peter2 = Person(firstName: "Cook", lastName: "Peter")
print(peter2.valueForKey("noExist"))

peter.valueForKey("lastName")

peter.valueForKey("noExist")



class Address: NSObject {
    
    var firstLine: String
    var secondLine: String
    
    init(firstLine: String, secondLine: String) {
        
        self.firstLine = firstLine
        self.secondLine = secondLine
        
    }
    
    
}

class PersonHandleKeyPath: NSObject {
    
    var firstName: String
    var lastName: String
    var address: Address
    
    init(firstName: String, lastName: String, address: Address) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        
    }
    
}


var peter3 = PersonHandleKeyPath(firstName: "Cook", lastName: "Peter", address: Address(firstLine: "Beijing", secondLine: "Haidian"))

print(peter3.valueForKeyPath("address.firstLine")!)

peter3.valueForKeyPath("address.firstLine")

peter3.setValue("swift", forKey: "firstName")

let view = UIView()

print(view.valueForKeyPath("superview.superview"))

class PersonForScalar : NSObject {
    
    var firstName: String
    var lastName: String
    var age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
    }
    
    override func setNilValueForKey(key: String) {
        
        if key == "age" {
            
            self.setValue(18, forKey: "age")
            
        }
    }
    
}

var person4 = PersonForScalar(firstName: "peter", lastName: "cook", age: 32)
person4.setValue(55, forKey: "age")
print(person4.valueForKey("age")!)
person4.setValue(nil, forKey: "age")

print(person4.valueForKey("age")!)

class PersonForCollection : NSObject {
    
    var firstName: String
    var lastName: String
    var friends: NSMutableArray
    
    init(firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.friends = NSMutableArray()
        
    }
    
    func countOfFriends() -> Int {
        
        return self.friends.count
        
    }
    
    func objectInFriendsAtIndex(index: Int) -> AnyObject? {
        
        return self.friends[index]
        
    }
    
}

var person33 = PersonForCollection(firstName: "peter", lastName: "cook")


person33.mutableArrayValueForKey("friends").count

person33.mutableArrayValueForKey("friends")[3]





