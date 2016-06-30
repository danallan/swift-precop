/*
* Dan Armendariz
* danallan@cs.harvard.edu
*
* Functions and parameter passing
*
*/

// Define functions with "func" keyword, specify parameters in parentheses
func printGradeCount(gradebook: [Int])
{
    if (gradebook.isEmpty)
    {
        print("The gradebook has no grades.")
    }
    else
    {
        print("The gradebook has \(gradebook.count) grades.", terminator: "")
    }
}

// Define a function's return type after an arrow
func average(gradebook: [Int]) -> Double?
{
    if gradebook.isEmpty
    {
        return nil
    }
    
    var sum = 0
    for grade in gradebook
    {
        sum += grade
    }
    return Double(sum) / Double(gradebook.count)
}

// define an array of grades
var grades: [Int] = [10, 100, 90, 95, 24]

// print the grade count
printGradeCount(grades)

// print the average
grades = []

// force unwrap -- generally unsafe, because it can cause runtime errors. Uncomment to see!
// let myAverage = average([])!

// unwrap the optional and, if present, store in a new constant
if let avg = average(grades)
{
    print("The gradebook average: \(avg)")
}
else
{
    print("The gradebook has no average.")
}
