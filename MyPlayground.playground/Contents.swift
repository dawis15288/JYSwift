//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let number = [1, 2, 3, 4]

let resulr = number.map { $0 * 2 }

print(resulr)

let strngResult = number.map {

    return "No.\($0)"
}

print(strngResult)

let flatmap = number.flatMap({
    
    return $0 + 2

})

print(flatmap)

let numbersCommpund = [[1, 2, 3], [4, 5, 6]]

var res = numbersCommpund.map({
    
    return $0.map({
        
        return $0 + 2
    
    })

})

print(res)

var flatRes = numbersCommpund.flatMap({

    return $0.map({
        
        return $0 + 2
    
    })
})

print(flatRes)

let oooptiionArray: [String?] = ["AA", nil, "BB", "CC"]

var pRes = oooptiionArray.flatMap({
    
    return $0

})

var mapRes = oooptiionArray.map {
    
    return $0 != nil ? $0 : "dd"
    
}

var flterRes = oooptiionArray.filter({
    
    return $0 != nil

})


print(mapRes)

print(flterRes)


var oREs = oooptiionArray.map({
    
    return $0

})

print(oREs)

print(pRes)



