/*:

# Game of Fifteen

**Dan Armendariz**\
[danallan@cs.harvard.edu](mailto:danallan@cs.harvard.edu)\
[iOS App Development with Swift](http://danallan.github.io/swift-precop/)

The Game of Fifteen is a puzzle game that is (normally) mechanically operated by sliding numbered plastic tiles around a game board. In a grid of 4 by 4 numbered tiles, with one missing, a player changes the order of the tiles by sliding them into the empty space. The goal is to arrange the tiles in order, with the empty tile in the lower-right corner. Try out the game at the below webpage!

[Play the Fifteen puzzle online](http://migo.sixbit.org/puzzles/fifteen/)

Over the next few days, we will work our way to implementing our first iOS app that will be a version of this game! To begin, though, we need to be able to recreate the game mechanic before we touch any iOS-specific code. This will allow us to focus on creating our first app when the time comes.

Fortunately, we can do this entirely with the constructs we have learned so far!

## Board Implementation: One-Dimensional Array

Up until now, we have dealt entirely with one-dimensional arrays. A single list of `Int` or `Character` items, for example.

!["One-dimensional array"](1d.pdf "One-dimensional array")

But our game board, shuffled, looks like this:

!["Game board"](gameboard.pdf "Game board")

So what can we do? Let's explore two ideas.

### Using a one-dimensional array

Imagine we take a table and want to collapse it into a list of items by simply taking the second row and moving it to the right of the first row, moving the third row after the second, and the fourth row after the third. This way, we turn a two-dimensional table into a one-dimensional array. Since we know that there's only 4 columns in a row, it is possible to use some arithmetic to identify the row and column from any index. Use the color coding in the following diagrams to see how this can work. From here on out, we'll use the number `16` to represent the empty tile.

We'll go from this:\
!["Two-dimensional array with marked rows"](2drows.pdf "Two-dimensional array with marked rows")

To this:\
!["One-dimensional array with columns"](1dcols.pdf "One-dimensional array with columns")

### Fetching values from a one-dimensional board

Let's solidify this idea with some code. Below we've created a one-dimensional (and shuffled) game board which matches the figures above. Complete the function that will allow us to fetch the value from the game board at a given a row and column. Keep in mind that rows and columns are 0-indexed. We'll also use the constant `EMPTY_TILE` to be the value `16` that represents the empty space.

Also try defining a flat board of your own and testing your function
with it!

*/
let EMPTY_TILE = 16
let flatBoard = [15, 3, 8, 1, 10, 4, 7, 14, 6, EMPTY_TILE, 2, 9, 5, 12, 11, 13]

/* valueFromFlat()
* Fetches a value from a one-dimensional representation of
* a game board given a 0-indexed row and column. It should
* return nil if the row or column requested are outside of
* the board.
*/
func valueFromFlat(board: [Int], row: Int, col: Int) -> Int?
{
    // TODO
    return 0
}

// test cases: all of the following should evaluate to true
valueFromFlat(flatBoard, 0, 0)! == 15
valueFromFlat(flatBoard, 2, 1)! == EMPTY_TILE
valueFromFlat(flatBoard, -1, 0) == nil
valueFromFlat(flatBoard, 4, 0) == nil
valueFromFlat(flatBoard, 1, 2)! == 7
valueFromFlat(flatBoard, 3, 1)! == 12
/*:

### Printing a one-dimensional board

We also want to print this board to the console. Complete the below function to accomplish this.

Use the underscore character, `_`, when printing the `EMPTY_TILE`. Try this function with other flat boards you have defined, as well.

*Hint:* You should only need a single `for` loop, but think about when you might need to use a `println()`!

*/
/* printFlat()
 * Given a one-dimensional representation of a board, will
 * print that board to the console as a table.
 */
func printFlat(board: [Int])
{
    /* TODO */
}

printFlat(flatBoard)
/*:

### Inserting values into a one-dimensional board

Given a row, a column, and a new value, we want to be able to insert a value into our one-dimensional, or flat, game board. Complete the below function to accomplish this task.

In the case that the requested row or column are outside of the board, return the board unmodified.

Notice that the function signature says `var board` in the parameter list. Normally, parameters are defined using an implied `let` and are immutable. Since it's implied, we generally don't have to type it (nor do we see it). Specifying `var` will allow you to modify the value of the board inside the function. Try removing `var` and see what happens!

*/
/* insertIntoFlat()
 * Insert a provided value into the row and column specified
 * of the one-dimensional board, and return the newly modified
 * board.
 */
func insertIntoFlat(var board: [Int], row: Int, col: Int, value: Int) -> [Int]
{
    /* TODO */
    return []
}

// TODO: write more tests to verify this works
insertIntoFlat(flatBoard, 0, 0, 3)
/*:

### Checking for a winning board

A player has won when the game board looks like this:

!["Solved game board"](won.pdf "Solved game board")

Write a function, whose signature is below, that performs this check on a one-dimensional game board.

Then, write some tests to check that your function works properly.

*/
/* wonFlat()
 * Return true if the provided board is in a 
 * winning configuration and false otherwise.
 */
func wonFlat(board: [Int]) -> Bool
{
    /* TODO */
    return false
}

// the below should be false, after implementation
wonFlat(flatBoard)

// TODO: also test with a board in other configurations!
/*:

Awesome, so far so good! Let's look at another way that we could implement the game board before proceeding with creating more of the game mechanic.

-----

## Board Implementation: Multi-Dimensional Array

There's another way we could represent the game board. Imagine, for a moment, if rather than create an array where every item is an `Int`, we create an array where every item is itself an array of `Int` items. An array of arrays, who would've thought! There's many ways to think about this: a list of lists, a matrix, or a table. We generally call it a two-dimensional array.

So how does this look? Well, when we wanted to create an array in the past, we specified the type of data that exists in every index. For example, `[Int]` is an array of `Int` items. `[Character]` is an array of `Character` items. If we wanted to create an array where every item was an array of `Int` items, we would write `[[Int]]`.

*/
var board: [[Int]]
/*:

!["WHOA"](whoa.jpg)

We would consider every item to be a row, and every row to be an array of columns. So we can re-create the same board that we previously represented in one-dimension as a two-dimensional array in the following way:

*/
board = [[15, 3, 8, 1],           /* zeroth row */
         [10, 4, 7, 14],          /* first row */
         [6, EMPTY_TILE, 2, 9],   /* second row */
         [5, 12, 11, 13]]         /* third row */
/*:

Pay special attention to the pattern of square brackets, which reveal how this is constructed. We placed all of these rows on separate lines for clarity, but you can also put them all in one line (try it yourself)!

This structure simplifies several of the tasks that we performed with the one-dimensional array. For example, if we wanted to grab the value from the 2nd row and 3rd column (don't forget it's 0-indexed!), we would simply write:

*/
board[2][3]
/*:

As we've done before, we use square brackets to pull values from indices in an array. So, `board[2]` would fetch the array that we're calling the second row. Since this is itself an array, we can fetch the third item by putting `[3]` at the end. So, `board[2][3]` fetches the 3rd column from the 2nd row in the board.

Here's a diagram that might help you visualize what's happening. An array whose items (or values) hold arrays, the values of those arrays contain our tile numbers.

!["Multi-dimensional array"](multi.pdf "Multi-dimensional array")

In the end, this means we can think about the game board in a way that's more intuitive, like this:

!["Rows and columns in game board"](rowcol.pdf "Rows and columns in game board")

Sound good? Let's try some exercises and see if that helps solidify this idea!

### Printing a two-dimensional board

We've already shown you how to get the value from a given row and column of a given board, so let's move directly into printing a two-dimensional board.

Complete the below function! Don't forget to use the underscore, `_`, when printing the `EMPTY_TILE`.

Test this function by defining some other two-dimensional game boards of your own.

*Hint:* You may want to have a nested `for` loop structure, one loop to iterate over the **rows** and one loop to iterate over that row's **columns**.

*/
/* printBoard()
 * Prints a two-dimensional board to the console.
 */
func printBoard(board: [[Int]])
{
    /* TODO */
}

printBoard(board)
/*:

### Checking for a winning board

Now let's check to see if a board is in a winning configuration! Complete the below function and test it with several shuffled and complete boards.

*/
/* won()
 * Returns true if the provided two-dimensional board
 * is in a winning configuration; false otherwise.
 */
func won(board: [[Int]]) -> Bool
{
    /* TODO */
    return false
}

// shuffled boards should be false
won(board)

// TODO: test boards in winning configurations
/*:

### Determine if a move is valid

One important aspect of recreating the Game of Fifteen in an app is that we need to ensure that we verify a move is valid before performing it. We want to prevent our game from blindly allowing a player to tap on any random tile to swap it with the empty one. We need to write a function that, given a row and column that the player provides, returns `true` if it is a valid move or `false` otherwise.

A valid move consists only of tiles that are directly adjacent (directly to the left, right, above, or below) the `EMPTY_TILE`. In our shuffled game board, as shown below, the only valid moves would be from the `4`, `6`, `2`, and `12` tiles.

!["Rows and columns in game board"](rowcol.pdf "Rows and columns in game board")

Be sure that your function does not allow diagonal moves! Tiles `10`, `7`, `5`, and `11` are currently invalid moves. Also, reject any moves whose rows or columns are not valid locations on the game board.

For those of you that are mathematically inclined, this function should return true when the [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) of the provided row and column is exactly 1 from the `EMPTY_TILE`.

Complete your implementation below.

*/
/* validMove()
 * Given a two-dimensional board, returns true if the 
 * Manhattan distance from a tile (specified by the
 * provided row and col) to the empty tile is exactly 1.
 * Returns false otherwise.
 */
func validMove(board: [[Int]], row: Int, col: Int) -> Bool
{
    /* TODO */
    return false
}

// Correct answers are in comments on right
validMove(board, 0, 0)  // false
validMove(board, 0, 1)  // false
validMove(board, 0, 2)  // false
validMove(board, 0, 3)  // false
validMove(board, 0, 4)  // false (and invalid!)
validMove(board, 1, 0)  // false
validMove(board, 1, 1)  // TRUE
validMove(board, 1, 2)  // false
validMove(board, 1, 3)  // false
validMove(board, 2, 0)  // TRUE
validMove(board, 2, 1)  // false
validMove(board, 2, 2)  // TRUE
validMove(board, 2, 3)  // false
validMove(board, 3, 0)  // false
validMove(board, 3, 1)  // TRUE
validMove(board, 3, 2)  // false
validMove(board, 3, 3)  // false

// You should also try test cases with the below board!
let testBoard = [[ 1,  2,  3, EMPTY_TILE],
                 [ 5,  6,  7,  4],
                 [ 9, 10, 11,  8],
                 [13, 14, 15, 12]]

// TODO: are there other boards and moves you should try?
/*:

### Slide a tile

We're getting closer and closer! We have created a lot of necessary building blocks in anticipation for a crucial step in the game: "sliding" a tile to the empty space.

Consider what has to happen in the situation that a user selects a tile to slide:
1. If the move is invalid, no tiles should move and the board must remain unchanged.
1. If the move is valid, we must swap the `EMPTY_TILE` with the selected tile.
1. Once the swap is complete, we must check if the user has won.
1. If the user won, we should congratulate them via a `println()`!
1. Finally, we should return the modified game board.

There's one thing we need to address: swapping. It's not only important in this function but is a useful task that you will use throughout your career as a programmer (and even later on in this exercise!), so let's try to get it right. Consider the following carefully, which is what you might be tempted to do if we asked you to swap the values of two new variables called `x` and `y`.
*/
var x = 4
var y = 6

// swap?
x = y
y = x

// uh oh 😞
x
y
/*:
Both of the variables became the same value of 6! To see why this is happening, bust out with a pen and paper, write a table of variables (like we've practiced in class) and look at the code sequentially: we create a variable `x` and set it to the value 4. We create variable `y` and set it to the value 6. Now, we overwrite the old value of `x` with the value from `y`, which is 6. So now both variables are equal to the same thing! 😬 In the next line, when we set `y` to the value of `x`, nothing is swapped because they are already the same!

One common way to fix this is to use a temporary variable that holds the value of `x`:
*/
var temp: Int
x = 4
y = 6

// swap!
temp = x
x = y
y = temp

// woo hoo! 😄
x
y
/*:
And to be extra cool, Swift provides a function called `swap` that does this for us. This function is a little strange, though, and requires ampersands to work properly, as shown below:
*/
x = 4
y = 6

// 😎
swap(&x, &y)

x
y
/*:

The ampersands allow the `swap` function to change the value of `x` and `y`. For now, don't worry about this particular syntax, but realize that it is very important for the `swap` function to work.

Whew, with that out of the way, we have now done a lot of the hard work to complete this function. Below, write the implementation to slide a tile by translating the above pseudocode into a new function that you write from scratch, with the below constraints on the signature.

* The function must be named `slideTile`
* The function must accept three parameters. A two-dimensional `board`, a `row`, and a `col`.
* The function must return a board, either modified (if a tile can be swapped) or unmodified (if the tile cannot be swapped).

*/
/* slideTile()
 * Given a two-dimensional board and a tile (specified by
 * a row and col), will return a modified board with
 * that tile swapped with the empty tile, if the move
 * is valid. If invalid, the board will remain unmodified.
 */
/* TODO */

// The below should change the board and swap the `12` tile with the empty
// board = slideTile(board, 3, 1)
// TODO, do lots of tests with your slideTile() function
/*:

### Almost there!!

Whew, we're getting there! Up until now we've been dealing with writing functions to handle the core game mechanic. Our approach of breaking down a big task ("implement the Game of Fifteen") into many small, bite-sized, well-defined functions is a common technique that you will frequently see programmers use. We recommend that you take an approach like this one when you work on programming projects of your own.

One other aspect of this method is that we defined game boards by hand (like the definition of `let flatBoard`, `let testBoard`, and `var board` throughout this Playground) in order to test the functions in a predictable way. Now that you have (hopefully) done the testing to be confident in your work, we can work our way to creating randomly-generated boards so we can actually play an interesting Game of Fifteen! As we work our way there, let's talk about some quirks of the board in a Game of Fifteen.

### Solvability of a board

There's a small problem we need to pay attention to before we can generate random boards. It turns out that if you randomly shuffle all 16 tiles (including not just the 15 numbered tiles but also the empty one), half of the time you will get a board that is impossible to solve. It's true! Try to solve this board, but don't waste too much of your time:

*/
let impossible = [[ 1,  2,  3,  4],
                  [ 5,  6,  7,  8],
                  [ 9, 10, 15, 12],
                  [13, 14, 11, EMPTY_TILE]]
/*:

We don't need to worry too much right now about the proof that shows that not all boards are possible. You can get an intuition for why this happens by imagining how you would try to solve the impossible board; you find out that no matter how many times you spin the bottom-right sequence of tiles, you can't get it to a working configuration.

To get around this issue, we have created an implementation of a solvability check in a function called `Staff.isBoardSolvable()`. Simply call this function and pass in a two-dimensional board and the function will return `true` if the board can be solved and `false` otherwise.

*/
Staff.isBoardSolvable(impossible) // false
Staff.isBoardSolvable(board)      // true
/*:

However, if you are looking for a little challenge, we highly encourage you to do research on this and complete your own implementation to verify that a shuffled board is solvable.

Here are some links to get you started:
* [Solvability of the Tiles Game (Ryan, M.)](https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html)
* [15 Puzzle (Slocum, J. and Weisstein, E. W.)](http://mathworld.wolfram.com/15Puzzle.html)
* [Solving the 15-puzzle (Calabro, C.)](http://cseweb.ucsd.edu/~ccalabro/essays/15_puzzle.pdf)

For the curious, our `Staff.isBoardSolvable()` solution uses the algorithm provided by Calabro in the "Solving the 15-puzzle" paper.

If you'd like to attempt this, complete the implementation below and use it to help you generate a shuffled board!

Some solutions may benefit from creating several "helper" functions in addition to `isBoardSolvable()`. Feel free to create more if you require them, but don't change the signature of `isBoardSolvable()`.

*/
/* isBoardSolvable()
 * Given a two-dimensional board, returns true if
 * the board can be solved or false otherwise by
 * computing **TODO (enter your solution method)**
 */
func isBoardSolvable(board: [[Int]]) -> Bool
{
    /* TODO for an additional challenge */
    return false
}

isBoardSolvable(impossible)
isBoardSolvable(board)
/*:

### Fixing an unsolvable board

You might be tempted to simply re-create a board from scratch if it's unsolvable, but that's unnecessary. All we need to do to fix it is to swap the locations of the `1` tile and the `2` tile. We've copied the `impossible` board below and made that change. Be sure to compare this board with the `impossible` one to see how it's been updated, and note that it's now solvable!

*/
let fixed = [[ 2,  1,  3,  4],
             [ 5,  6,  7,  8],
             [ 9, 10, 15, 12],
             [13, 14, 11, EMPTY_TILE]]

Staff.isBoardSolvable(fixed) // true!!
/*:

Complete the function below that swaps the `1` and `2` tile. Rather than do a true "swap", you might consider just changing the `1` to a `2` and vice versa.

*/
func swapTilesOneAndTwo(var board: [[Int]]) -> [[Int]]
{
    /* TODO */
    return board
}

// fixed now!
Staff.isBoardSolvable(swapTilesOneAndTwo(impossible))

// oops, made a solvable board impossible!
Staff.isBoardSolvable(swapTilesOneAndTwo(board))

/*:

### Constructing a shuffled board

Now that we've resolved the issue of verifying the solvability of a board, we can actually be sure we can create a shuffled board that is also solvable. This operation requires several steps, some of which we haven't shown you before, so we'll carefully guide you through it.

Swift doesn't have a built-in way to generate a random number, but fortunately one does exist in something called a "library." A library is a collection of functions that someone else has written that we can easily import in our code to make those functions available in our code. In this case, Apple has written a library called `UIKit` that includes functions for many things that will be useful for us over the next week (like drawing things to the screen of an iOS device) and it happens to include a pseudorandom number generator. With the below line of code, we can make all of those functions available to us.
*/
import UIKit
/*:

In this way, we can use existing functions that other people have written and reduce the amount of work that we have to do ourselves. If you think about it, the overall goal of this Playground is to essentially write something a lot like a library that supports functions to model the Game of Fifteen.

By the way, in programming, "UI" generally stands for "User Interface." The fact that this library is called "UIKit" hints that it is a package of functions that are useful for manipulating user interfaces, and we will be leveraging this more in the coming week.

Technically speaking, `UIKit` itself is importing another library called `Darwin`, and it is this library that contains the random number generator. Why is that library called `Darwin`? Well, Mac OS X (and iOS) are built on top of an operating system called [Darwin](https://en.wikipedia.org/wiki/Darwin_(operating_system)) that supplies many of the core components in those systems.

The details don't matter for now, but we thought we'd just mention it in case you were wondering. All we need to care about is that `UIKit` makes available new functions we haven't seen before, among which is a pseudorandom number generator.

-----

#### Why do we keep saying *pseudo*random?

Since computers can only follow a very rigid set of instructions it turns out to be impossible to ask a computer to simply "pick a number out of thin air" and give us a truly random result. What this means is that, even though people have worked hard to create an algorithm that looks like it generates a series of random numbers, the numbers are not *truly* random. For our purposes, it will appear random enough, but we always call these sorts of functions *pseudo*random to acknowledge that they are not, in fact, truly random.

-----

The pseudorandom number generator that we have available to us through `UIKit` is called `arc4random_uniform()`. It's a bit of a crazy name, but it will do exactly what we want. Let's say we pass it an `Int` called `n`, it will return to us a pseudorandum number in the range `[0, n)`. In other words, it will return one of `n` random numbers, starting from 0, and since it's 0-indexed, it does not include the number `n`. This is just like the indices of an array, since they go from 0 to the item count minus 1!

So if we type `arc4random_uniform(5)`, it will return one of the values 0, 1, 2, 3, or 4. Let's try it! Add more lines of `arc4random_uniform()` to see the numbers it generates.
*/
Int(arc4random_uniform(5))
Int(arc4random_uniform(5))
Int(arc4random_uniform(5))
/*:

You'll see that we also used `Int()` with `arc4random_uniform()`. The reason for this is that `arc4random_uniform()` returns a `UInt32` type, which is a variant of an `Int`, but not exactly the same. Specifically, the number of bits is different. In any case, the `Int` type is more useful in Swift, so explicitly converting it will reduce errors.

Alright, so far so good, we hope! But we don't want to just run `arc4random_uniform(16)` and return a random number from `[0, 16)` for each tile. We might generate two tile numbers that are the same number and produce an invalid board, so we'll instead want to randomly swap the tiles on a valid board.

In comes the [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle). This algorithm will allow us to shuffle a board with no duplicates or missing tiles into a random configuration that we will then verify is solvable. Below is some pseudocode to describe how it works. Try writing a list of numbers from 1 to 16 on a sheet of paper and performing the steps to see how well it behaves.

1. Generate the numbers 1 through 16 in order on the board.
1. Start from the "end" of the board (the empty tile in the lower-right corner) and swap that tile with any other randomly-picked tile anywhere on the board.
1. Move to the second-to-last tile (to the left of the lower-right corner), and randomly swap that with any other randomly-picked tile anywhere on the board.
1. And so on, until we reach the top-left of the board.

It is the "randomly-picked tile" part where we will leverage the `arc4random_uniform()` function to randomly pick a row and column for the tile swap.

By the way, remember how I said we would need to use `swap()` again? Here it is!

Whew! Now we _finally_ have all the pieces we need to complete our board generation function. To do so, we need to perform several steps:
1. Generate a board that is identical to a "won" board.
1. Perform the Fisher-Yates shuffle on that board.
1. If the board is invalid (don't forget `Staff.isBoardSolvable()`, or use your own implementation of `isBoardSolvable()` if you did it!) then fix it by using your `swapTilesOneAndTwo()` function.
1. Return the shuffled board

Ready? We started implementing this code just for you. Fill in all of the `TODOs` to complete this last function.

*/
/* generateBoard()
 * Creates and returns a valid, solvable, game of 
 * fifteen board represented by a two-dimensional array.
 */
func generateBoard() -> [[Int]]
{
    // create a blank board
    var board: [[Int]] = [[]]
    
    // Step 1: generate a won board with tiles from 1 to 16
    for i in 0 ..< EMPTY_TILE
    {
        /* TODO */
    }

    // Step 2: perform the Fisher-Yates shuffle
    for n in 0 ..< EMPTY_TILE
    {
        // count backwards
        let tile = 15 - n

        // figure out the current row and column from tile
        /* TODO */

        // generate a random row and column to swap the current tile
        /* TODO */
        
        // complete the swap
        /* TODO */
    }
    
    // Step 3: fix a broken board
    if !Staff.isBoardSolvable(board)
    {
        board = swapTilesOneAndTwo(board)
    }

    // Step 4: return the completed board
    return board
}

// try generating a couple boards!
generateBoard()
generateBoard()
/*:

## DONE!! 🎉🎈👍

Woo hoo, that's it! Nicely done. Soon we'll put all of this into an iOS app!

If you have some extra time, attempt the Hacker edition, which can support different difficulty levels of the game! And even though we call it the "Hacker edition", if you paid close attention to the design of each of your functions, they should only need a minimal amount of modification to complete the work!

-----

## Hacker Edition

An alternative version of this is the _n-puzzle_, which is a generalized form of the Game of Fifteen. In this form, a 15-puzzle is exactly identical to (and in fact, the term is interchangeable with) the Game of Fifteen we've been discussing. A 3-puzzle has the same mechanics but with a 2x2 board. 8-puzzle has a 3x3 board, and so on. It can work with any perfect square.

For an added challenge, adapt all of the functions you wrote for a two-dimensional board to work with any n-puzzle. Use the EMPTY_TILE variable to describe the size of the board. If that variable is changed to 4, for instance, the functions should work for a 3-puzzle and the tile numbered `4` becomes the empty tile. Every function you wrote should function in the expected manner: board generation should create a 2x2 board, tile swapping should continue to function as specified, board printing should work and look correct, _etc_. Supporting this version is precisely why we had the variable `EMPTY_TILE`, as opposed to hard-coding 16 everywhere!

Your task will be to figure out how to change all of the functions (without changing their signatures! in other words, don't change their parameter lists, types, or output types) to work in the general case.

You will need to use an alternate version of the staff solvability checker which you can call like this: `Staff.isBoardSolvable(newBoard, size: EMPTY_TILE)`, which is a checker that works for the more general n-puzzle case. As a matter of fact, internally, `Staff.isBoardSolvable(board)` simply calls the more generic function with a size of 16. If you implemented `isBoardSolvable()` and you decide to make the modifications for this general case, carefully test your solution against a variety of board sizes. Not all solvability checking algorithms support the general n-puzzle.

If you decide to make these modifications, you will easily be able to support an "Easy" (8-puzzle), "Medium" (15-puzzle), and "Hard" (24-puzzle) mode in your future iOS app!

*/
