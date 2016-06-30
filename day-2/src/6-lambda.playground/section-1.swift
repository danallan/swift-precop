/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Closures using anonymous functions. Shorter syntax.
 *
 */


// Assume x^y where y is an integer.
// Still closures, shorter syntax:
func powerOf(y: Int) -> ((Double) -> Double)
{
    // This is an "anonymous" function becasue it doesn't have a name
    return { (x: Double) -> Double in
        // temporary variable
        var result: Double = 1.0
        
        // multiply the result times x Y times
        for _ in 1...y
        {
            result = result * x
        }
        
        // return the result
        return result
    }
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
