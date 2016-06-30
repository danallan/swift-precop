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

// Create a square and a cube function
let square = powerOf(2)
let cube = powerOf(3)

// define an array of numbers
let numbers: [Double] = [1, 4, 7, 2, 5, 10, 56]

// Now let's perform one of our operations on all numbers in the list:
var result: [Double] = []
for value in numbers
{
    result.append(square(value))
}
result

result = []
for value in numbers
{
    result.append(cube(value))
}
result

// Ugh! Duplication of code.
