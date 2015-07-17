/* cheng and dan */

/* ELIOT TWO */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


1      Pick a character

Given a string and a number, print the character in the string
at the location provided by number (0-indexed).

Hint: We can create an array of characters from a string like this:

    var string = "Danana"
    var stringArray = Array(string)

In the above code snippet, stringArray would be
["D", "a", "n", "a", "n", "a"]

Okay, go pick a letter!


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


func characterAt(str: String, index: Int) -> Character
{
    /* TODO */
    return "😒"
}

println("1      Pick some chars\n")

let hi = "Ohai there!! 😊"
println(characterAt(hi, 0))
println(characterAt(hi, 1))
println(characterAt(hi, 13))

println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

2      Print ... numbers?

So it turns out that computers secretly represent letters as numbers.
This system that translate numbers to letters is called ASCII.

Let's take a quick look at https://en.wikipedia.org/wiki/ASCII ...


Hmm, that wasn't very fun. But if we scroll down on that page, there's
a nice blue chart that we can use. What do the headings mean? Well
"Binary" is just binary (base 2), "Oct" is octal (base 8), "Dec" is
decimal (base 10), and "Hex" is hexadecimal (base 16). Right now, we
probably just care about base 10, since that's what we humans use.
"Glyph" is just a fancy word for character. So let's see ... towards
the top of the second column, we see the Glyph "A", and the decimal
equivalent of that is 65. That seems strange ... but makes sense,
right? If computers, at their lowest level, can only store data as
binary, then all the characters it sees must also be numbers. So the
world decided on this standard, ASCII, that converts numbers to
characters.

Alright, let's see this in action, shall we?

*/

// A regular string, as we are accustomed to seeing:
let fruit = "DANANA"

// Convert the string to a list of numbers representing each character
let asciiFruit = [UInt8](fruit.utf8)

/* This takes the "UTF8", or numeric representation of our fruit string,
and puts it into an array of "UInt8"s, where each item is a separate
character. What's UInt8? Well, it's just a specific kind of Integer.
The U means that the numbers are "unsigned", or that there are no 
negative numbers (get it, no signs??), Int means that we want integers,
and 8 means that we want 8 bits per integer. On the right, we see that
this gets us [66, 65, 78, 65, 78, 65], where each number corresponds 
to the character in that position of "DANANA".

See how "D" was 68 and "A" was 65? I bet you thought I was crazy, right?

Try changing the fruit string and see how the numbers change!

And, just to prove we can, let's say each number on a separate line: */

for number in asciiFruit
{
    println(number)
}
println()

/*

Okay, great! Time to show some ASCII! To make it very easy to see
which number corresponds to which letter, print each letter on 
a line followed by a colon and its ASCII representation. So, 
printASCII("DANANA") should print:
D: 68
A: 65
N: 78
A: 65
N: 78
A: 65

printASCII("Hi there!") should print:
H: 72
i: 105
 : 32
t: 116
h: 104
e: 101
r: 114
e: 101
!: 33


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */



func printASCII(message: String)
{
    /* TODO */
}

println("2      Print  ... numbers?\n")

// whoa!
printASCII("Hi there!")

println()

// Find out what your name is in ASCII!
printASCII("YOUR NAME")


println("\n")



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

3      Print ... letters?


Given an array of numbers, print the characters they represent in ASCII.


Turns out, Swift has a weird type called UnicodeScalar (even cheng
doesn't really understand it) that's sort of both a number and a
character all at the same time. (But that kind of makes sense, since a
computer knows them both as the same anyways, right?) It's necessary to
have this because Swift supports more than just the relatively simple 
table of ASCII characters; Emoji, for instance, are represented by a
system similar to ASCII called Unicode that represents a much wider range
of characters. These characters include accents, characters from a very
diverse set of languages, and Emoji. UnicodeScalar ensures that Swift can
support latin characters (like our letters) and the vast set of other
characdters like Emoji and accents at the same time.

In any case, we can convert a number to a UnicodeScalar like this:

*/

let unicodeA = UnicodeScalar(65)

// And now we can convert it to a string that's only one-character long:
let stringContainingA = String(unicodeA)

// Bonus hint! Don't forget about concatenating two strings together:
let thing_one = "Thing one and "
let both_things = thing_one + "thing two."

/* 

Alright, time to convert numbers to letters!

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


func printLetters(numbers: [Int])
{
    /* TODO */
}

println("3      Print  ... letters?\n")

// This one is easy, and it's a good test to make sure things are working.
printLetters([65, 66, 67])

println()

// Aren't you curious what this message says??
printLetters([84, 105, 109, 101, 32, 102, 108, 105, 101, 115, 32, 108, 105, 107, 101, 32, 97, 110, 32, 97, 114, 114, 111, 119, 44, 32, 102, 114, 117, 105, 116, 32, 102, 108, 105, 101, 115, 32, 108, 105, 107, 101, 32, 98, 97, 110, 97, 110, 97, 115, 46])

println()
println()
