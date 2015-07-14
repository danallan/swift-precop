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
        println("The gradebook has no grades.")
    }
    else
    {
        println("The gradebook has \(gradebook.count) grades.")
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
let myAverage = average(grades)!
if let avg = average(grades)
{
    println("The gradebook average: \(avg)")
}
else
{
    println("The gradebook has no average.")
}
