/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Now we're just getting fancy.
 *
 * Run this code in an Xcode Playground by double-clicking its file in Finder.
 */

// Darwin library provides "pow" function
import Darwin

// Wouldn't it be great to have a new operator, **, that takes exponents for us?
// doesn't work: 2 ** 3 :(

// Swift allows us to define our own operators!
// Note that we shouldn't use "^" because that operator exists for other functions.
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
func ** (lhs: Double, rhs: Double) -> Double
{
    return pow(lhs, rhs)
}

// Sweet! We have a new operator!
2 ** 3
2 ** 10

let e = 2.718
e ** 2

// Redefine powerOf with the new operator:
func powerOf(y: Double) -> ((Double) -> Double)
{
    // Use Swift's built-in pow function
    return { $0 ** y }
}

// What is the returned value if we run powersOf? A function!
let square = powerOf(2)

// That means square is now a function that we can run:
square(3)

// But wait, we can create another!
let cube = powerOf(3)

// Works!
cube(2)

// Each maintains independent control over their initial parameters.
square(5)
cube(5)
square(4.5)
cube(8.9)

// You may also occasionally see this syntax, which immediately runs the returned function:
powerOf(5)(4) // 4^5
