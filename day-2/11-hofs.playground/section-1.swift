/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Higher order functions.
 *
 */

// Darwin library provides "pow" function
import Darwin

// Define exponentiation operator.
infix operator **
{
    // more information on associativity and precedence:
    // https://developer.apple.com/library/ios/documentation/swift/conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/doc/uid/TP40014097-CH32-XID_736
    // pow operator is left associative
    associativity left

    // precedence for exponent is higher than other operators, like +
    precedence 170
}

// Define the actual computation that occurs with our new operator
func ** (x: Double, y: Double) -> Double
{
    return pow(x, y)
}

// Redefine powerOf with the new operator:
func powerOf(y: Double) -> ((Double) -> Double)
{
    // Use Swift's built-in pow function
    return { $0 ** y }
}

// Create a higher-order function, one that "maps" a provided function over an entire array
func mapper(list: [Double], f: (Double) -> Double) -> [Double]
{
    // a list to store the results
    var newlist: [Double] = []
    
    // apply f() to every value in list
    for value in list
    {
        newlist.append(f(value))
    }
    
    // return the result
    return newlist
}


// Create a higher-order function, one that "maps" a provided function over an entire array
func filter(list: [Double], f: (Double) -> Bool) -> [Double]
{
    // a list to store the results
    var newlist: [Double] = []
    
    // apply f() to every value in list
    for value in list
    {
        if (f(value))
        {
            newlist.append(value)
        }
    }
    
    // return the result
    return newlist
}

// Create a square and a cube function
let square = powerOf(2)
let cube = powerOf(3)

// define an array of numbers and an array for results
let numbers: [Double] = [1, 4, 7, 2, 5, 10, 56]
var result: [Double] = []

// Perform operations on all numbers in the list:
result = mapper(numbers, f: square)
result = mapper(numbers, f: cube)

// We can still use Swift's anonymous function syntax
result = mapper(numbers, f: { $0 / 2.0 })
result
