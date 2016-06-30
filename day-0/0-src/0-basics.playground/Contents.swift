// Dan Armendariz
// danallan@cs.harvard.edu
//
// Swift basics

// Define constants (immutable variables) with "let"
let instructor = "Dan Armendariz"

// define variables with "var"
var score = 10
var highScore = 5
var won = false

////////
// Boolean expressions

// equality
1 == 0

// greater than
1 > 0
score > 5

// greater than or equal to
1 >= 1
1 >= 0

// less than
1 < 5
score < highScore

// less than or equal to
2 <= 2
2 <= 3

// inequality
3 != 5

///////////
// Logical operators

// NOT: negation
!true  // not true
!(2 == 3)
2 != 3
!won

// AND: are both things true?
true && true
true && false
false && true
false && false

// OR: is *either* thing true?
true || true
true || false
false || true
false || false

// You can combine operators for compound expressions!
!false && false || true


var A = true
var B = true
// Exercise: given two boolean variables, A and B, what operations do I do
// to achieve the following result?
// A | B | A ? B
// 1 | 1 | 0
// 1 | 0 | 0
// 0 | 1 | 1
// 0 | 0 | 0



// Solution: !A && B



// Exercise: Given A and B, what operations provide the following?
// A | B | A ? B
// 1 | 1 | 0
// 1 | 0 | 1
// 0 | 1 | 1
// 0 | 0 | 0



// This is called exclusive OR, or XOR!
// Solution: (A && !B) || (!A && B)



//////
// Arithmetic

// Basic stuff you'd expect!
4 + 6
3 * 4
10 - 55

// And some stuff you don't ...
10 / 3

// Integer division is an important part of computing.
// You need to tell Swift that you want to operate on decimals (called "doubles") to get a decimal answer.
10.0 / 3.0
10.0 / 3.0

// There is a "remainder" operator. Normally called "modulo" but it behaves slightly differently in Swift
10 % 3
// 10 divided by 3 is 3 with remainder 1

// Compound expressions are, of course, possible, and follow the rules you expect
(10 + 2) * 3


///////
// Conditions

if true {
    print("This will always be printed")
}
else {
    print("This will never be printed!")
}

// alright!! we won!
won = true

// did we beat the high score?
if won && score > highScore
{
    print("Woot! You beat the old high score of \(highScore * 2)!!!")
    highScore = score
}



/*
 * Loops
 *
 * Loops allow repetition of blocks of code.
 * We'll show a couple types here and expand on them in later days.
 */

// a for loop allows us to iterate sequentially
// a range of 0 ... 3 is [0, 3]: 0, 1, 2, 3
// a range of 0 ..< 3 is [0, 3): 0, 1, 2
for i in 0 ... 3
{
    print("i has a value of: \(i)")
}

// a "while" loop continues to loop until a condition is false

var currentTile = 10
let finishTile = 50
var diceRoll = 1
while (currentTile <= finishTile)
{
    // update dice (really should be random, though)
    diceRoll = 5

    // our current tile should change based on the roll
    currentTile = currentTile + diceRoll
}

///////
// Functions

func printHighScore()
{
    print("The high score is \(highScore)")
}

printHighScore()
