/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Closures
 *
 */

// Let's say we need to do a lot of exponents with a fixed value.
// We might want to make a function like this, for x^2:
func powerOf2(x: Double) -> Double
{
    // temporary variable
    var result: Double = 1.0

    // multiply the result times x TWO times
    // The _ variable is a dummy variable
    for _ in 1...2
    {
        result = result * x
    }

    // return the result
    return result
}

powerOf2(2.0)
powerOf2(3.2)
// and so on.

// Now let's do powers of 3.
func powerOf3(x: Double) -> Double
{
    // temporary variable
    var result: Double = 1.0
    
    // multiply the result times x THREE times
    for _ in 1...3
    {
        result = result * x
    }
    
    // return the result
    return result
}

powerOf3(2.0)
powerOf3(3.2)


// This isn't ideal. We can obviously make this more generic by passing in the exponent, but our goal is to have a single function that always takes a single number and provides its square or cube.
// Let's use a "closure" to make this more generic. 
// Assume x^y where y is an integer.
func powerOf(y: Int) -> ((Double) -> Double)
{
    // define a function that accepts a parameter and adds that parameter to the value x. Whenever sum is run, y and summed with the existing x value.
    // this is our generic exponent function.
    func exponentiator(x: Double) -> Double
    {
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

    // return the *function*!
    return exponentiator
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
