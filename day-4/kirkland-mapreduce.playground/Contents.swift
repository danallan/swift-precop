/*

In class, we went over closures, anonymous functions ("lambdas"), and higher-order functions, like map. Be sure to review that source code since we went over it quickly.

In this set of exercises, we'll use two higher-order functions, map and reduce, to count words and word pairs, also known as unigram words and bigram words.

This is just a taste of the kind of programming that's involved in computing huge amounts of data. If you've heard the term "Big Data", it is related to this idea. The reason this is so powerful is that "mapping" a function over a huge list of data can be a task that can be easily performed by many computers simultaneously. Given enough computers tackling a single task, a huge data set can be processed in a very short amount of time.

MapReduce and Hadoop are systems that use a map step and then a reduce step to perform complicated computations. There may be several map steps and severla reduce steps, but many problems can be broken down into individual functions with these two steps. 

In this exercise, we're going to use some elements of this kind of processing to count the most common letter unigrams (single characters),  bigrams (character pairs), word unigrams (single words), and word bigrams (word pairs in a text.
See: http://en.wikipedia.org/wiki/Bigram

To prepare for this exercise, create a folder called "Shared Playground Data" in your Documents folder and place aliceandwonderland.txt inside of it.

*/

import UIKit

// this library allows us to access data from ~/Documents/Shared Playground Data
import XCPlayground

/*
 * MapReduce() performs an approximation of the steps involved
 * in a standard MapReduce setup by taking an input file,
 * splitting it into lines, applying a mapper function on
 * each line, collapsing all the values for a specified key,
 * running a reducer for all the values of a given key,
 * and finally sorting the result.
 */
func MapReduce(file: String, mapper: (String -> [(key: String, value: Int)]), reducer: (String, [Int]) -> (key: String, total: Int)) -> [(key: String, total: Int)]
{

    /* LOAD FILE CONTENTS */
    
    // load the file
    let content = NSString(contentsOfFile: file, usedEncoding: nil, error: nil)
    
    // check the optional for a value
    if content == nil
    {
        println("Sorry, cannot load the file!")
        exit(EXIT_FAILURE)
    }

    /* MAP STEP */

    // split the file into an array of lines
    let lines = String(content!).componentsSeparatedByString("\n")

    // store the result (an array of tuples) in this variable
    var pairs: [(key: String, value: Int)] = []

    // apply the mapper on each line in the file
    for line in lines
    {
        pairs += mapper(line)
    }
    
    /* SHUFFLE STEP: aggregate all values for a given key */

    // a dictionary of keys and an array of values
    var collapsed: [String: [Int]] = [:]
    
    // iterate over every pair of keys and values
    for (key, value) in pairs
    {
        if let values = collapsed[key]
        {
            // append a value to the list of values
            collapsed[key] = values + [value]
        }
        else
        {
            // no values yet, create a list of them
            collapsed[key] = [value]
        }
    }

    /* REDUCE STEP: provide all values of a key to the reducer */
    
    var data: [(key: String, total: Int)] = []
    for (key, values) in collapsed
    {
        let output = reducer(key, values)
        data.append(output)
    }
    
    /* SORT STEP: sort the output by values in descending order */
    
    data.sort({ $0.total > $1.total })
    
    /* DONE! */
    return data
}

/*
 * mapperUnigram takes a line as a String and splits it
 * into individual characters, picking only letters,
 * upper-casing them, and returning an array of tuples
 * with each letter as a key and a count of 1.
 */
func mapperUnigram(line: String) -> [(key: String, value: Int)]
{
    var output: [(key: String, value: Int)] = []

    // convert the string to uppercase and iterate over its chars
    for c in line.uppercaseString
    {
        if (c >= "A" && c <= "Z")
        {
            // the letter is uppercase! add it to our value list
            let pair = (key: String(c), value: 1)
            output.append(pair)
        }
    }
    
    return output
}

/*
 * reducerCount() takes all of the values for a given key
 * and sums them, to count how many times that value
 * appears for that key.
 */
func reducerCount(key: String, values: [Int]) -> (key: String, total: Int)
{
    // rely on built-in reduce HOF to sum all values
    let sum = values.reduce(0, combine: +)
    return (key: key, total: sum)
}


// define the location of the file on disk
let aliceInWonderland = XCPSharedDataDirectoryPath.stringByAppendingPathComponent("aliceinwonderland.txt")

// Playgrounds are slow: uncomment this when you want to see the result (but you'll need to let your computer work for a while)
//println(MapReduce(aliceInWonderland, mapperUnigram, reducerCount))
