//: Playground - noun: a place where people can play

import Foundation

func doMath (first: Int, second: Int, handler: (total:Int, difference: Int) -> Void ) {
    let total = first + second
    let difference = second - first
    handler(total:total, difference:difference) // call the handler function
}

// a standalone handler function
var myHandler: (total:Int, difference: Int) -> Void = {total, difference in
    print("total = \(total)")
    print("difference = \(difference)")
}

// another standalone handler function
var myOtherHandler: (total:Int, difference: Int) -> Void = { total, difference in
    print("the total is \(total) and the difference is \(difference)")
}

// calling the math function with the two handlers:
doMath(4, second: 13, handler: myHandler)
doMath(4, second: 13, handler: myOtherHandler)

func gotMath() {
    
    doMath(50, second: 30) {(total, difference) in
        
            print("*** The total is \(total) and the difference is \(difference)")
    }
}
gotMath()

func takeMath(score: Int, var pass: Bool, completionHandler: (score: Int) -> Void) {
    switch score {
    case 50:
        pass = true
    default:
        pass = false
    }
    completionHandler(score: score)
}

takeMath(50, pass: true) { score in
    
    print("the passing grade is \(score)")
    
    
}

func myView(key: String) {
    doMath(100, second: 300) {(total, difference) in
    let product = total * difference
    print("This is weird. The product is now \(product) with the passing in string is \(key)")
    }
    
    takeMath(50, pass: true) {
        score in
            print("Completion Handler of takeMath is called")
    }
}

myView("Happy Coding")

/* Auto Closure */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// customerProvider is () -> String. A default String array property.
let customerProvider = { customersInLine.removeAtIndex(0) }
// Equivalent to hisProvider. The customerInLine String array infers to () -> String therefore it can be omitted.
let hisProvider: () -> String = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)
// Type A. Define the function
func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
// Implement the closure by calling the function with customerProvider closure defined.
serveCustomer( { customersInLine.removeAtIndex(0) } )

/*Auto escape */
// Type B. with @autoclosure. customersInLine is ["Ewa", "Barry", "Daniella"]
// It implies noescape.
func serveCustomer(@autoclosure customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

// It skips the { } as it assumes closure inside the ( )
// The argument is automatically converted to a closure, because the customerProvider parameter is marked with the @autoclosure attribute.

serveCustomer(customersInLine.removeAtIndex(0))
// prints "Now serving Ewa!"

//Type C: with @autoclosure(escaping). customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")
// prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// prints "Now serving Barry!"
// prints "Now serving Daniella!"

