/*:
 
# Day 2 Answers

## Problem 1: Reduce
Create a `reduce` function that is higher-order. It should accept an array of doubles (`[Double]`), an initial value `i` of type `Double`, and a function `f`, which itself takes as parameter two `Double` values and returns a `Double`. The function calls `f` first with the initial condition and the first element in the list, and stores the output. It then takes the output, and calls `f` with the output and the next element in the list, and so on. In short, it combines all of the elements in the list to a single value by relying on a function `f` to do the combination. Below is a sample of how you might call the function, which when run should return the value `10.0`, since it sums the values in the list.
*/
func reduce (list: [Double], i: Double, f: (Double, Double) -> Double) -> Double
{
    var x = i
    for el in list
    {
        x = f(el, x)
    }
    return x
}

let r = reduce([1.0, 2.0, 3.0, 4.0], i: 0.0, f: +)
/*:
 ## Problem 2: HOF practice
 
 First, we'll define our other HOFs -- `filter` and `mapper` -- from class.
 */
func filter (list: [Double], f: (Double -> Bool)) -> [Double]
{
    var result: [Double] = []
    for el in list
    {
        if f(el)
        {
            result.append(el)
        }
    }
    return result
}

func mapper (list: [Double], f: (Double -> Double)) -> [Double]
{
    var result: [Double] = []
    for el in list
    {
        result.append(f(el))
    }
    return result
}
/*:
 ### Problem 2.1
 Multiply all elements of a list together.
 */
let nums = [1, 7, 23, -2, 0.5]

reduce(nums, i: 1.0, f: *)

// or with built-ins:
nums.reduce(1.0, combine: *)
/*:
 ### Problem 2.2
 Transform an array of values represented in Fahrenheit to Celsius.
 */
typealias Fahrenheit = Double

let temps: [Fahrenheit] = [32.0, 212, -40, 72, 50, 114]
let celsius = { (5.0/9.0) * ($0-32) }

mapper(temps, f: celsius)

// built-ins:
temps.map(celsius)
/*:
 ### Problem 2.3
 Find the largest element of a list.
 */
reduce(nums, i: nums[0], f: max)

// built-in:
nums.reduce(nums[0], combine: max)
/*:
 ### Problem 2.4
 Transform a double array into it's reciprocal values. Be sure to get rid of 0s!
 */
let inv = [-0.5, 0, 8]

filter(inv, f: { $0 != 0 })
filter(inv) { $0 != 0 }

let recip = mapper(filter(inv) { $0 != 0 }) { 1 / $0 }
recip

// built-in:
let brecip = inv.filter({ $0 != 0 }).map({ 1 / $0 })
brecip
/*:
 ## Problem 3: Quick Sort
 Write a function called `quickSort` that takes in an unsorted `Double` array and outputs a sorted `[Double]`. [Quicksort works](https://www.khanacademy.org/computing/computer-science/algorithms/quick-sort/a/overview-of-quicksort) by selecting a "pivot" element, partitioning the array into three categories: all elements smaller than or equal to the pivot, the pivot, and all elements larger than the pivot, and then recursively applying quicksort to each category. Because it is recursive, quicksort has a base case when the array size is 1: it should just return the array. As a small hint, this function should use at least one of the higher order functions we discussed in class!
 */
func quickSort(list: [Double]) -> [Double]
{
    // a list of one or zero is already sorted
    if list.count <= 1
    {
        return list
    }
    
    // make list mutable, and fetch first element (and remove it from the array)
    var list = list
    let pivot = list.removeFirst()
    
    // recursive calls to sort els on both sides of pivot
    let lhs = list.filter { $0 <= pivot }
    let rhs = list.filter { $0 > pivot }

    return quickSort(lhs) + [pivot] + quickSort(rhs)
}

quickSort([])
quickSort([0, 1, 2, 3])
quickSort([1, 3, 3, 3, 2])
quickSort([1, 3, 3, 2, 3])
quickSort([1, 3, 3, 2, 3, 2])
quickSort([0, 6, -3, 5, 6, 3, 1, 3, 3, 10, -5.3])
/*:
 ## Problem 4: Curry
 Write a function, called `curry`, that accepts a function that normally requires two `Double` parameters (like `pow`), and allows partial application of that function. In other words, although we'd normally call `pow(x, y)`, after we pass it to curry we should get a new function, `exp`, that allows `exp(x)(y)`. More specifically, although we'd normally run `pow(2, 3)`, perhaps we only want to partially apply the function as follows:
 ```
 let exp = curry(pow)
 let base = exp(2)
 base(3) // outputs 8
 ```
 */
// pay particular attention to the type of curry!
func curry(f: (Double, Double) -> Double) -> (Double -> (Double -> Double))
{
    // an anonymous function that accepts param x and itself returns
    // another anonymous function that accepts param y and returns f(x, y)
    return { x in { y in f (x, y) } }
}

import Darwin

let exp = curry(pow)
let base = exp(2)
base(3)

nums
nums.map(base)
nums.map(curry(+)(1))
