/******
 *
 * Generics
 *
 * Jack Deschler
 * deschler.jack@gmail.com
 ******/

// Recall our old implementation of filter
// now called filterDouble
func filterDouble(list: [Double], f: (Double -> Bool)) -> [Double]
{
    var acc: [Double] = []
    for elt in list
    {
        if (f(elt))
        {
            acc.append(elt)
        }
    }
    return acc
}

// Filter for numbers that are > 2
let doubles = [1.2,3.5,2.3,0.5]
var gt2 = filterDouble(doubles, f: { $0 > 2 })
gt2

// But what if we want to filter a list of Ints?
// We have to write a new function
func filterInt(list: [Int], f: (Int -> Bool)) -> [Int]
{
    var acc: [Int] = []
    for elt in list
    {
        if (f(elt))
        {
            acc.append(elt)
        }
    }
    return acc
}

// Filter to find the odds
let ints = [1,2,3,4,5,6,7]
var odds = filterInt(ints, f: { $0 % 2 == 1 })
odds

// What about Strings?
// Yet another function
func filterString(list: [String], f: (String -> Bool)) -> [String]
{
    var acc: [String] = []
    for elt in list
    {
        if (f(elt))
        {
            acc.append(elt)
        }
    }
    return acc
}

// Filter to find the five letter Strings
let strings = ["abracadabra","cabot","fred","apples","dan", "swift", ]
var fiveLetters = filterString(strings, f: { $0.characters.count == 5 })
fiveLetters


// Does this annoy you? Hint: it should.
// Is there a better way? Hint: yes
// Here is the ideal implementation of filter
// Since it is usable on all data types, we call it _generic_
func filter<T>(list: [T], f: (T -> Bool)) -> [T]
{
    var acc: [T] = []
    for elt in list
    {
        if f(elt)
        {
            acc.append(elt)
        }
    }
    return acc
}

// do the same filtering excercises as above
gt2 = filter(doubles, f: { $0 > 2 })
gt2
odds = filter(ints, f: { $0 % 2 == 1 })
odds
fiveLetters = filter(strings, f: { $0.characters.count == 5 })
fiveLetters

// swapping!
func swap<T>(inout a: T, inout b: T)
{
    let temp: T = a
    a = b
    b = temp
}

var a = 2
var b = 3
swap(&a, &b)
a
b
