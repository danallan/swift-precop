/*:
 
 # MapReduce
 
 In class, we went over closures, anonymous functions ("lambdas"), and higher-order functions, like `map` and `filter`. Be sure to understand those concepts before approaching this document.
 
 In this set of exercises, we'll use two higher-order functions, map and reduce, to count words and word pairs, also known as unigram words and bigram words.
 
 This is just a taste of the kind of programming that's involved in computing huge amounts of data. If you've heard the term "Big Data", it is related to this idea. The reason this is so powerful is that "mapping" a function over a huge list of data can be a task that can be easily performed by many computers simultaneously. Given enough computers tackling a single task, a huge data set can be processed in a very short amount of time.
 
 MapReduce and Hadoop are systems that use combinations of a map step and, subsequently, a reduce step to perform complicated computations. There may be several map steps and several reduce steps, but many problems can be broken down into individual functions with some combination of these two steps.
 
 In this exercise, we're going to use some elements of this kind of processing to count the most common letter unigrams (single characters),  bigrams (character pairs), word unigrams (single words), and word bigrams (word pairs in a text. Wikipedia is a good place to start for [information on bigrams](http://en.wikipedia.org/wiki/Bigram).
 
 To prepare for this exercise, create a folder called "Shared Playground Data" in your Documents folder and place `aliceinwonderland.txt` inside of it.
 
 */
import UIKit
/*:
 ## MRData
 
 A common type of data passed around during processing and final output in MapReduce systems is an array of tuples that combine a key with a value. This is not to be confused with a dictionary, since a given array might contain many tuples with the same key. As you'll see, these keys are eventually combined in the reduce step.

 ### typealias
 
 `typealias` is a declaration that allows you to name an existing type or types. Typically it is called `typealias [name] = [type]` and this will allow you to use the type `[name]` in addition to the existing `[type]`.
 */
typealias MRData = (key: String, value: Int)
/*:
 ## mapReduce()
 
 This function performs an approximation of the steps involved in a standard MapReduce setup by taking an input file, splitting it into lines, applying a mapper function on each line, collapsing all the values for a specified key, running a reducer for all the values of a given key, and finally sorting the result. Don't forget that we're providing this mapReduce function only as a demonstration of one common framework that could be used to distribute computation across many machines. If you were writing code with the explicit intention of performing *n*-gram analysis on a document, you would likely architect this differently.
 
 It is common for a MapReduce system to operate on a line-by-line basis because it is a very convenient way to store data in a sensible way in plain text files. These files may come from many different sources: logs written by servers, database entries, text documents (as we're working with here), and others.
 */
func mapReduce(file: NSURL, mapper: (String -> [MRData]), reducer: (String, [Int]) -> MRData) -> [MRData]
{
    
    /* LOAD FILE CONTENTS */
    
    // load the file, catching any exceptions it throws
    let content = try? NSString(contentsOfURL: file, encoding: NSUTF8StringEncoding)
    
    if content == nil
    {
        print("Sorry, cannot load the file!")
        exit(EXIT_FAILURE)
    }
    
    /* MAP STEP */
    
    // split the file into an array of lines and performs the map step on each
    let lines = String(content!).componentsSeparatedByString("\n")
    
    // apply the mapper on each line
    var pairs: [MRData] = []
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
    let reduced: [MRData] = collapsed.map(reducer)
    
    /* SORT STEP: sort the output by values in descending order */
    let final = reduced.sort({ $0.value > $1.value })
    
    /* DONE! */
    return final
}
/*:
 
 ## mapperUnigram
 
 Takes a String representing a line and splits it into individual characters, picking only letters, upper-casing them, and finally returning an array of tuples with each letter as a key and a count of 1.
 */
func mapperUnigram(line: String) -> [MRData]
{
    // return an array of MRData where every letter has a val of 1
    return line.uppercaseString.characters
        .filter({ $0 >= "A" && $0 <= "Z" })
        .map({ (key: String($0), value: 1) })
}
/*:
 
 ## reducerCount
 
 Receives all values for a given key and sums them. Since the mapper provided a count of `1` for every letter, this will ultimately return the count that a character (provided in "key") appears in the corpus.
 
 */
func reducerCount(key: String, values: [Int]) -> MRData
{
    // rely on built-in reduce HOF to sum all values
    let sum = values.reduce(0, combine: +)
    return (key: key, value: sum)
}
/*:
 
 ## Load file from disk
 */
// this library allows us to access data from "~/Documents/Shared Playground Data"
import XCPlayground

// define the location of the file on disk
let aliceInWonderland = XCPlaygroundSharedDataDirectoryURL.URLByAppendingPathComponent(("aliceinwonderland.txt"))
/*:
 
 ## Ready?
 
 Playgrounds are slow: uncomment this line when you want to see the result -- but you'll need to let your computer work for a while!
 
 */
//print(mapReduce(aliceInWonderland, mapper: mapperUnigram, reducer: reducerCount))
/*:
 
 ## Exercise: customMapper
 
 Now you'll get the chance to generate some interesting statistics of your own! Your task will be to create a new mapper and (if necessary) a new reducer. Our mapper, `mapperUnigram`, splits a line into individual English letters. Ultimately, this allows us to see the frequency of every letter in a text.
 
 First, pick one of the following: character bigrams, word unigrams (single words), or word bigrams (word pairs). Bigrams tend to generate more interesting results than unigrams, but are also more challenging to generate.
 
 Assume we have the string "Oh, hello! You're awesome.".
 
 1. Character bigrams are the set of consecutive letter pairs in a word. We ignore punctuation inside of a word. So, from the above string, we would obtain the following character bigrams: "OH", "HE", "EL", "LL", "LO", "YO", "OU", "UR", "RE", "AW", "WE", "ES", "SO", "OM", "ME"
 2. Word unigrams are simply the individual words in a text. Notice that we preserve apostrophes, but throw away other punctuation: "OH", "HELLO", "YOU'RE", "AWESOME"
 3. Word bigrams are consecutive words, preserving apostrophes but throwing away other punctuation: "OH HELLO", "HELLO YOU'RE", "YOU'RE AWESOME"
 
 Pick one of the above, and write a `customMapper` that supports it. Be sure to test **thoroughly** before running it on the _Alice in Wonderland_ text. You may want to quickly skim through real-world text (like the _Alice in Wonderland_ file, and perhaps others) to see if there are interesting cases not listed here that you must handle. We'll allow you to decide for yourself how to handle cases not described here.
 
 Note that there's a little bit of a problem doing word bigram analysis using a MapReduce-like system. You can only generate bigrams for a given line! If a sentence spans a line (take our example above and imagine the second sentence is on the next line) then this will impact the results. It's OK to ignore this for now. If we wanted to fix it, we would likely adapt the MapReduce system to pass a line number, and incorporate that into a tuple, then combine those in a reduce step before completing the key count.
 */
func customMapper(line: String) -> [MRData]
{
    return []
}


// Ready? You sure you've tested enough? Ok -- uncomment the following line!
//print(mapReduce(aliceInWonderland, mapper: customMapper, reducer: reducerCount))
