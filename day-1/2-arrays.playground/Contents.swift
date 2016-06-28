/*
* Dan Armendariz
* danallan@cs.harvard.edu
*
* Arrays
*
*/

// Define a mutable array (or list) of grades, which are each integers
// Recall: What does "mutable" mean?
var grades: [Int] = [100, 0, 90, 85]

// access the size of the array with the "count" property and dot syntax
print("The gradebook has \(grades.count) grades.")

// add a new grade to the gradebook
// Note: we cannot do grades[4] = 95 because the array has a fixed length
grades.append(95)

// alternatively, we can do the following
grades += [70, 80]

// Sum the grades.
var sum = 0

// Iterate over every item in the array [0, grades.count)
// Note: the array is 0-indexed!
for index in 0 ..< grades.count
{
    // print the grade
    print("Grade \(index + 1): \(grades[index])")
    
    // add the grade to the sum
    sum += grades[index]
}

// compute the average (remember, *both* sides must be double!)
let average = Double(sum) / Double(grades.count)
print("Average: \(average)")
