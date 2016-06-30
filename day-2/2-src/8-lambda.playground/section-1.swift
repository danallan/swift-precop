/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Less contrived exponentiator example.
 *
 */

// Darwin library provides "pow" function
import Darwin

func powerOf(y: Double) -> ((Double) -> Double)
{
    // Use Swift's built-in pow function
    return { pow($0, y) }
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
