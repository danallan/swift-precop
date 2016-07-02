/*:
 
 # Game of Fifteen
 
 **Dan Armendariz**\
 [danallan@cs.harvard.edu](mailto:danallan@cs.harvard.edu)\
 And the staff of Swift Precop\
 [iOS App Development with Swift](http://danallan.github.io/swift-precop/)
 
 The Game of Fifteen is a puzzle game that is (normally) mechanically operated by sliding numbered plastic tiles around a game board. In a grid of 4 by 4 numbered tiles, with one missing, a player changes the order of the tiles by sliding them into the empty space. The goal is to arrange the tiles in order, with the empty tile in the lower-right corner. For example, you might start out with a board that looks like this:
 
 !["Game board"](gameboard.pdf "Game board")
 
 And need to slide tiles into the empty position until you achieve this, at which point you've won:
 
 !["Solved game board"](won.pdf "Solved game board")
 
 Try out the game [on this site](http://migo.sixbit.org/puzzles/fifteen/)!
 
 Over the next few days we will work our way to implementing an honest-to-goodness iOS version of this game! To begin, though, we need to be able to recreate the game mechanic before we touch any iOS-specific code. The goal of this document, then, is to work through the design of the data structure and the functions necessary for game mechanics.
 
 Let's look at ways to implement the board.
 
 ## Board Implementation: Multi-Dimensional Array
 
 One way we could represent the game board is with a multi-dimensional array. Imagine, for a moment, that rather than create an array where every item is an `Int`, we create an array where every item is itself an array of `Int` items. An array of arrays, who would've thought! There's many ways to think about this: a list of lists, a matrix, or a table. We generally call it a two-dimensional array.
 
 So how does this look? Well, when we wanted to create an array in the past, we specified the type of data that exists in every index. For example, `[Int]` is an array of `Int` items. `[Character]` is an array of `Character` items. If we wanted to create an array where every item was an array of `Int` items, we would write `[[Int]]`.
 
 We would consider every item to be a row, and every row is an array of columns. Each of the tiles will be numbered sequentially, starting from 0, and we'll define the empty tile as `15` in a constant called `EMPTY_TILE`. Although this results in tiles that are numbered one less than they appear on the final game board, it will have numerous advantages as we'll see later.
 
 */
let EMPTY_TILE = 15
let board2D = [[14, 2, 7, 0],          /* zeroth row */
               [9, 3, 6, 13],          /* first  row */
               [5, EMPTY_TILE, 1, 8],  /* second row */
               [4, 11, 10, 12]]        /* third  row */
/*:
 
 Pay special attention to the pattern of square brackets, which reveal how this is constructed. We placed all of these rows on separate lines for clarity, but you can also put them all in one line (try it yourself)!
 
 This structure leads to a simple mental model for the game board. For example, if we wanted to grab the value from the 2nd row and 3rd column (don't forget it's 0-indexed!), we would simply write:
 
 */
board2D[2][3]
/*:
 
 As we've done before, we use square brackets to pull values from indices in an array. So, `board[2]` would fetch the array that we're calling the second row. Since this is itself an array, we can fetch the third item by placing `[3]` at the end. The expression `board[2][3]` therefore fetches the 3rd column from the 2nd row in the board.
 
 Here's a diagram that might help you visualize what's happening. An array whose items (or values) hold arrays, the values of those arrays contain our tile numbers.
 
 !["Multi-dimensional array"](multi.pdf "Multi-dimensional array")
 
 In the end, this means we can think about the game board in a way that's fairly intuitive, like this:
 
 !["Rows and columns in game board"](rowcol.pdf "Rows and columns in game board")
 
 Sound good? Let's use this board representation in a couple functions!
 
 ### Printing a two-dimensional board
 
 We've already shown you how to get the value from a given row and column of a given board, so let's move directly into printing a two-dimensional board.
 
 Complete the below function! Use the underscore, `_`, to represent the `EMPTY_TILE`. Every other tile should summed with `1` to output the final form of the game board as players will see it. In other words, the output of this function when provided `board2D` should be a text version of the game board image shown at the top of this document.
 
 Test this function by defining other two-dimensional game boards of your own.

 */
/* printBoard(_:)
 * Prints a two-dimensional board to the console.
 */
func printBoard(board: [[Int]])
{
    /* TODO */
}

printBoard(board2D)
/*:
 
 ### Checking for a winning board
 
 A player has won when the game board looks like this:
 
 !["Solved game board"](won.pdf "Solved game board")
 
 But don't forget that we represent the game board with the tile numbers 0-indexed. Write a function, whose signature is below, that performs this check on a two-dimensional game board. Be sure to test it with several shuffled and complete boards.
 
 */
/* won(_:)
 * Returns true if the provided two-dimensional board
 * is in a winning configuration; false otherwise.
 */
func won(board: [[Int]]) -> Bool
{
    /* TODO */
    return false
}

// shuffled boards should be false
won(board2D)
// TODO: test boards in various configurations
/*:

-----

 ## Board Implementation #2: One-Dimensional Array
 
 There's another way we could represent the game board that avoids the need for nested loops or nested higher-order functions: a flat, single-dimensional array. It's a relatively small change that improves the brevity of code, and although it increases the complexity slightly of thinking about the layout of the board, it makes reasoning about certain things slightly easier.
 
 ### Using a one-dimensional array
 
 Imagine we take a table and want to collapse it into a list of items by simply taking the second row and moving it to the right of the first row, moving the third row after the second, and the fourth row after the third. This way, we turn a two-dimensional table into a one-dimensional array. Since we know that there's only 4 columns in a row, it is possible to use some arithmetic to identify the row and column from any index. Use the color coding in the following diagrams to see how this can work.
 
 We'll go from this:\
 !["Two-dimensional array with marked rows"](2drows.pdf "Two-dimensional array with marked rows")
 
 To this:\
 !["One-dimensional array with columns"](1dcols.pdf "One-dimensional array with columns")
 
 Let's create a `typealias` for this board representation, named `Tiles`, to represent the fact that the board is represented by an array of `Int`s whose values are the tiles.
 */
typealias Tiles = [Int]
/*:
 Below is the representation of our same board from above in a single dimension.
 */
let board1D: Tiles = [14, 2, 7, 0, 9, 3, 6, 13, 5, EMPTY_TILE, 1, 8, 4, 11, 10, 12]
/*:

 ### Index and position helper functions
 
 We can create a couple of helper functions to help us deal with this alternative way of representing the board. First, we'll create a function that accepts a row and a column (as a tuple) and returns the corresponding index in the one-dimensional representation of the board.
 
 Then, we'll create a function that does the opposite: accepts an index and returns a tuple of ints representing the row and column of that index: `(row: Int, col: Int)`.
 
 In fact, this tuple representing a position on the game board is common enough that we might as well provide a name to it. We'll `typealias` this tuple and name it `Position` as a convenience so that we can refer to this 2-tuple of `Ints` with that label throughout this document:
 
 */
typealias Position = (row: Int, col: Int)
/*:
 Now, we'll create the helper functions.

 ### Converting positions to indices
 
 Take a look the representation of the one-dimensional game board, above, to remind yourself how this is designed, which might help inform the algorithm you use. Don't forget that we continue to use 0-indexing for both rows and columns.
 
 */
/* positionToIndex(_:)
 * Accepts a tuple of a tile on the board and
 * returns the corresponding index of that
 * tile on a 1D array.
 */
func positionToIndex(pos: Position) -> Int
{
    // TODO
    return 0
}

//TODO: test this thoroughly!

/*:
 ### Converting indices to positions
 
 Now the reverse. Slightly trickier, but not by much!
 */
/* indexToPosition(_:)
 * Takes an index of a tile in a 1D array, and
 * returns a 2-tuple of ints that represent that
 * tile's location on the board.
 */
func indexToPosition(index: Int) -> Position
{
    // TODO
    return (0, 0)
}

//TODO: test this. Try all possible indices!

/*:
 ### Printing a one-dimensional board.
 
 We'll also want the ability, like the two-dimensional board, to print out our single dimensional representation for debugging purposes. Complete that function below. Don't forget to properly handle the `EMPTY_TILE` and add `1` to every tile.
 */
/* printBoard(_:)
 * Prints a one-dimensional board to the console.
 */
func printBoard(board: Tiles)
{
    /* TODO */
}

printBoard(board1D)
/*:
 ### Checking for a winning board
 
 And of course, we'll need a way to determine if the player has won. Write the `won()` function based on a `Tiles` one-dimensional game board.
 */
/* won(_:)
 * Returns true if the provided Tiles board
 * is in a winning configuration; false otherwise.
 */
func won(board: Tiles) -> Bool
{
    /* TODO */
    return false
}

won(board1D)
// TODO: test boards in various configurations
/*:
 The `won()` function for a `Tiles` board can be fairly concise and simpler than the same function for a two-dimensional board, which is convenient!

 We'll come back to implementing other functions to handle game play in a moment. For now, let's take a look at generating game boards.
 
 -----
 
 ## Generating a Board
 
 Up until now we've been dealing with writing functions to handle the core game mechanic. Our approach has been to break down a big task ("implement the Game of Fifteen") into many small, bite-sized, well-defined functions while evaluating our design decisions as we go, going back to make adjustments as necessary. This is a common technique that programmers frequently use, and one we recommend you add to your toolkit when working on projects of your own!
 
 Up until now, we have defined game boards by hand (like the definition of `let board2D`, and `let board1D`) in order to test the functions in a predictable way. Now that you have (hopefully) done the testing to be confident in your work, we can work our way to creating randomly-generated boards so we can actually play an interesting Game of Fifteen. As we work our way there, let's talk about some quirks of the game.
 
 We'll eventually want to generate a random board that the user can play on. One idea might be to start with a board in the "won" state and randomly select valid tiles to move for a random number of times. However, this sounds fairly complex. What if we randomly placed tiles somewhere on the board?
 
 ### Solvability of a board
 
 There's a small problem that we must address before we can generate random boards by randomly placing tiles. It turns out that if you generate a board in this way, by random assignment of tiles to locations, you will have generated a board that is impossible to solve about half of the time. It's true! Try to solve this board, represented as a one-dimensional `Tiles` board. But don't waste too much of your time trying to solve this one!
 
 */
let impossible = [  0,  1,  2,  3,
                    4,  5,  6,  7,
                    8,  9, 14, 11,
                   12, 13, 10, EMPTY_TILE]
/*:
 
 There is a proof that exists that demonstrates that not all boards are possible, though we won't concern ourselves with the details of the proof at the moment. You can get an intuition for why this happens by imagining how you would try to solve the impossible board; you find out that no matter how many times you spin the bottom-right sequence of tiles, you can't get it to a working configuration.
 
 To get around this issue, we have created an implementation of a solvability check in a function called `Staff.isBoardSolvable()`. Simply call this function and pass in either a two-dimensional board or a `Tiles` board and the function will return `true` if the board can be solved, `false` if it cannot, or `nil` if the board is malformed and the function cannot find the `EMPTY_TILE`.
 
 */
Staff.isBoardSolvable(impossible) // false
Staff.isBoardSolvable(board1D)    // true
Staff.isBoardSolvable(board2D)    // true
/*:
 
 However, if you are looking for a little challenge, we highly encourage you to do research on this and complete your own implementation to verify that a shuffled board is solvable.
 
 Here are some links to get you started:
 * [Solvability of the Tiles Game (Ryan, M.)](https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html)
 * [15 Puzzle (Slocum, J. and Weisstein, E. W.)](http://mathworld.wolfram.com/15Puzzle.html)
 * [Solving the 15-puzzle (Calabro, C.)](http://cseweb.ucsd.edu/~ccalabro/essays/15_puzzle.pdf)
 
 For the curious, our `Staff.isBoardSolvable()` solution uses a mix of solutions provided by Calabro in the *Solving the 15-puzzle* paper and Ryan, M., in *Solvability of the Tiles Game*.
 
 If you'd like to attempt this, complete the implementation below and use it to help you generate a shuffled board!
 
 Some solutions may benefit from creating several "helper" functions in addition to `isBoardSolvable()`. Feel free to create more if you require them, but don't change the signature of `isBoardSolvable()`.
 
 */
/* isBoardSolvable(_:)
 * Given a Tiles board, returns a bool indicating
 * if the board can be solved (nil on error) by
 * computing [..TODO, enter your solution method..]
 */
func isBoardSolvable(board: Tiles) -> Bool?
{
    /* optional TODO, for an additional challenge */
    return nil
}

isBoardSolvable(impossible)
isBoardSolvable(board1D)
/*:
 
 ### Fixing an unsolvable board
 
 You might be tempted to use a while loop to continuously re-generate new boards until you receive one that is solvable, but that's unnecessary. All we need to do to fix an unsolvable board is to swap the locations of the first two tiles. In the case of the board representations we've been using, we swap the `0` tile with the `1` tile. Really!
 
 !["WHOA"](whoa.jpg)
 
 We've copied the `impossible` board below and made that change. Be sure to compare this board with the `impossible` one to see how it's been updated, and note that it's now solvable!
 
 */
let fixed = [ 1,  0,  2,  3,
              4,  5,  6,  7,
              8,  9, 14, 11,
             12, 13, 10, EMPTY_TILE ]

Staff.isBoardSolvable(fixed) // true!!
/*:

 Complete the function below that swaps the `0` and `1` tile. Rather than do a true "swap", you might consider just changing the `0` to a `1` and vice versa.
 
 */
/*
 * swapTilesZeroAndOne(_:)
 * accepts a Tiles board and returns a new Tiles
 * board with the `0` and `1` tiles exchanged.
 */
func swapTilesZeroAndOne(board: Tiles) -> Tiles
{
    /* TODO */
    return board
}

// fixed now!
Staff.isBoardSolvable(swapTilesZeroAndOne(impossible))

// oops, made a solvable board impossible!
Staff.isBoardSolvable(swapTilesZeroAndOne(board1D))


/*:
 
 ### Constructing a shuffled board
 
 Now that we've resolved the issue of verifying the solvability of a board, we can actually be sure we can create a shuffled board that is also solvable. This operation requires several steps, some of which we haven't shown you before, so we'll carefully guide you through it.
 
 Swift doesn't have a built-in way to generate a random number, but fortunately one does exist in the `UIKit` library. The library includes a number of useful methods that we'll use frequently, like drawing things to the screen of an iOS device, but it also happens to include a pseudorandom number generator. With the below line of code, we can make all of those functions available to us.
 */
import UIKit
/*:
 
 In this way, we can use existing functions that other people have written and reduce the amount of work that we have to do ourselves. In the end, the overall goal of this Playground is to essentially write something a lot like a library (although we won't use it as one) that supports functions to model the Game of Fifteen.
 
 By the way, in programming, "UI" generally stands for "User Interface." The fact that this library is called "UIKit" hints that it is a package of functions that are useful for manipulating user interfaces, and we will be leveraging this more in the coming week.
 
 Technically speaking, `UIKit` itself is importing another library called `Darwin`, and it is this library that contains the random number generator. Why is that library called `Darwin`? Well, Mac OS X (and iOS) are built on top of an operating system called [Darwin](https://en.wikipedia.org/wiki/Darwin_(operating_system)) that supplies many of the core components in those systems.
 
 The details don't matter for now, but we thought we'd just mention it in case you were wondering. All we need to care about is that `UIKit` makes available new functions we haven't seen before, among which is a pseudorandom number generator.
 
 -----
 
 #### Why do we keep saying *pseudo*random?
 
 Since computers can only follow a very rigid set of instructions it turns out to be impossible to ask a computer to simply "pick a number out of thin air" and give us a truly random result. What this means is that, even though people have worked hard to create an algorithm that looks like it generates a series of random numbers, the numbers are not *truly* random. For our purposes, it will appear random enough, but we always call these sorts of functions *pseudo*random to acknowledge that they are not, in fact, truly random.
 
 -----
 
 The pseudorandom number generator that we have available to us through `UIKit` is called `arc4random_uniform()`. Despite the whacky name it provides precisely the functionality we want. Let's say we pass it some `n` of type `Int`, it will return to us a pseudorandum number in the range `[0, n)`. In other words, it will return one of `n` random numbers, starting from 0, and since it's 0-indexed, it does not include the number `n`, similar to the indices of an array.
 
 If we call `arc4random_uniform(5)`, it will return one of the values 0, 1, 2, 3, or 4. Let's try it! Add more lines of `arc4random_uniform()` to see the numbers it generates.
 */
Int(arc4random_uniform(5))
Int(arc4random_uniform(5))
Int(arc4random_uniform(5))
/*:
 
 You'll see that we also used `Int()` with `arc4random_uniform()` to explicitly typecast the function's `UInt32` return type to the `Int` type that we're using more frequently.
 
 Alright, so far so good, we hope! But we don't want to just run `arc4random_uniform(16)` and return a random number from `[0, 16)` for each tile. We might generate two tile numbers that are the same number and produce an invalid board, so we'll instead want to randomly swap the tiles on a valid board.

 In comes the [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle). This algorithm will allow us to shuffle a board with no duplicates or missing tiles into a random configuration that we will then verify is solvable. Below is some pseudocode to describe how it works. Try writing a list of numbers from 0 to 15 on a sheet of paper and perform the steps manually to see how well it behaves.
 
 1. Generate the numbers 0 through 15 in order on the board.
 1. Start from the "end" of the board (the empty tile at the end, the lower-right corner of the board) and swap that tile with a randomly-picked tile anywhere *before* it on the board.
 1. Move to the second-to-last tile (to the left of the lower-right corner), and randomly swap that with a randomly-picked tile anywhere before it on the board.
 1. And so on, until we reach the top-left of the board.
 
 It is the "randomly-picked tile" part where we will leverage the `arc4random_uniform()` function to randomly pick a row and column for the tile swap.

 There's one more thing you'll need to accomplish the shuffle: swap values. Remember the `swap()` we defined in class? It's actually a Swift built-in function! Well, technically speaking, `swap()` is provided by the standard library that's automatically included with the language, but we can think of it as "built-in".
 
 */
var x = 4
var y = 6

// 😎
swap(&x, &y)

x
y
/*:
 
 Recall that the ampersands are necessary to permit the parameters to be modified by the function.
 
 Whew! Now we _finally_ have all the pieces we need to complete our board generation function. To do so, we need to perform several steps:
 1. Generate a board that is identical to a "won" board.
 1. Perform the Fisher-Yates shuffle on that board.
 1. If the board is invalid (don't forget `Staff.isBoardSolvable()`, or use your own implementation of `isBoardSolvable()` if you did it!) then fix it by using your `swapTilesZeroAndOne()` function.
 1. Return the shuffled board
 
 */
/* generate()
 * Creates and returns a valid, solvable, game of
 * fifteen board of type `Tiles`.
 */
func generate() -> Tiles
{
    return []
}

// try generating a couple boards!
generate()
generate()

/*:

 -----
 
 ## Game play mechanics

 Whew, we're getting there! Now that we know how to generate a board, let's finish up by completing functions for all of the game play mechanics.
 
 ### Fetching position from a tile
 
 As you've seen, this one-dimensional board representation we've called `Tiles` is very useful when generating a board. It's also extremely useful when computing the solvability of the board, but unless you implemented `isBoardSolvable()` you'll just have to take our word on that. But let's now more carefully consider the design decision of our `Tiles` board in the context of the user interaction for a game. Using arrays (either single- or multi-dimensional) in the manner described at the beginning of this Playground lends itself well to asking the user to input the row and column of the tile they are interested in moving and performing the necessary modifications to the board.
 
 But this isn't necessarily the best user experience. Rather than allow the user to input the `Position` of the tile, why not allow them to specify the tile itself that they want to move? This not only makes more sense when implementing the game for keyboard input, but also for touch input via an iOS app, as well. A tile object drawn on screen in an iOS app, for example, can very easily keep track of its tile value (since it's already displaying it anyway!), but would require more work to somehow allow a tile to "remember" its own position, and keep that position completely in sync and always up-to-date with the game board representation in a one- or two-dimensional array. Having the same values (in this case, the position of a tile in a game board) replicated in multiple places is a recipe for broken and messy code that's difficult to troubleshoot.
 
 To enable this, create a function called `getIndexFromTile()` that accepts a one-dimentional `Tiles` board and a tile number and returns the tile's position (or index in the array) on the board.
 
 */
/* getIndexFromTile(_:board:)
 * Returns the index of a tile in a 1D board of tiles
 * or returns nil if the tile does not exist.
 */
func getIndexFromTile(tile: Int, board: Tiles) -> Int?
{
    /* TODO */
    return nil
}
/*:
 
 -----
 
 The function you just implemented reveals that our first pass at a data structure to model the board, although extremely useful to generate the board, is not necessarily ideal during game play. The most common action in the game is the user pressing a tile to cause it to move. Having to search the entire array for the tile at every input feels needlessly inefficient, even if the array is small. Let's consider alternative approaches that we can use during play.
 
 ## Board Implementation #3: Inverted One-Dimensional Array
 
 How about another design idea: an inverted one-dimensional array. In this array, the indices represent the *tile numbers*, and the values represent the *tile positions*. The game board we've been working with until now, then, would be represented as follows:
 
 !["Inverted one-dimensional game board"](1dinvert.pdf "Inverted one-dimensional game board")
 
 And in code below.
 */
let boardInv = [3, 10, 1, 5, 12, 8, 6, 2, 11, 4, 1, 13, 15, 7, 0, 9]
/*:
 
 In this model, the last element of the array, index `15`, is our `EMPTY_TILE`. We can find the location of the empty tile by finding its value! Use the `indexToPosition` function on a variety of tiles in this inverted board to discover what's happening.
 */
indexToPosition(boardInv[EMPTY_TILE])
// try more here

/*:
 
 -----
 
 ## Board Implementation #4: Inverted One-Dimensional Array of Positions
 
 We can make one final modification. Since an array isn't limited to just `Int` types, why don't we make things easier on ourselves and simply store the row and column `Position` value at every location? Our board would then look like the below.
 
 !["Inverted 1D game board of positions"](1dinvpos.pdf "Inverted 1D game board of positions")
 
 Observe how easy it is to find the position from any tile number. This representation is so convenient that we will end up using this game board representation during game play, so let's provide a `typealias` for it. We'll name the alias `TilePositions`, to make clear that the board is represented by the positions of the tiles as the values.
 */
typealias TilePositions = [Position]
/*:
 We'll then represent the game board with this declaration.
 */
var board: TilePositions = [(0, 3), (2, 2), (0, 1), (1, 1),
                            (3, 0), (2, 0), (1, 2), (0, 2),
                            (2, 3), (1, 0), (3, 2), (3, 1),
                            (3, 3), (1, 3), (0, 0), (2, 1)]
/*:
 ### Checking for a winning board
 
 Let's re-examine our old (and, by now, quite familiar) friend, the `won()` function. Implement it, below, for our new `TilePositions` type.
 */
/*
 * won(_:)
 * accepts a board of TilePositions
 * and returns a boolean value representing
 * the winning state of the board.
 */
func won(board: TilePositions) -> Bool
{
    /* TODO */
    return false
}
 
// TODO add tests to verify your function
 
/*:
 
 Now that we've settled on a representation of the board during play, let's finish up the necessary functions for the game mechanics.
 
 ### Determine if a move is valid
 
 One important aspect of recreating the Game of Fifteen in an app is that we need to ensure that we verify a move is valid before performing it. We want to prevent our game from blindly allowing a player to tap on any random tile to swap it with the empty one. We need to write a function that, given the tile the player selects, returns `true` if it is a valid move or `false` otherwise.
 
 A valid move consists only of tiles that are directly adjacent (directly to the left, right, above, or below) the `EMPTY_TILE`. In the shuffled game board we've been using, shown again below in the representation as a user would interact with it, the only valid moves would be from the `4`, `6`, `2`, and `12` tiles.
 
 !["Game board"](gameboard.pdf "Game board")
 
 Be sure that your function does not allow diagonal moves! Tiles `10`, `7`, `5`, and `11` are invalid moves with the tiles in this arrangement. Also, the function must reject any moves from any tile that is not actually on the board.
 
 We might describe this function as returning true when the [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) of the provided row and column is exactly 1 from the `EMPTY_TILE`.
 
 Complete your implementation below. When you're done, consider the additional complexity required had you written this function with another board representation, like the `Tiles` type or a two-dimensional array!
 
 */
/* validMove(_:board:)
 * Given a one-dimensional board, returns true if the
 * Manhattan distance from a valid tile to the empty
 * tile is exactly 1. Returns false otherwise.
 */
func validMove(tile: Int, board: TilePositions) -> Bool
{
    /* TODO */
    return false
}

// test your function for *all* possible tiles
// Don't forget our tiles are represented -1 from what is displayed
validMove(12, board: board) // false
validMove(11, board: board) // true

// You should also try test cases with the below board!
let testBoard = [0,  1,  2, EMPTY_TILE, 4, 5,  6,  3, 8, 9, 10,  7, 12, 13, 14, 11]

// TODO: are there other boards and moves you should try?

/*:
 
 ### Slide a tile
 
 We're getting closer and closer! We have created a lot of necessary building blocks in anticipation for a crucial step in the game: "sliding" a tile to the empty space.
 
 Consider what has to happen in the situation that a user selects a tile to slide:
 1. If the move is invalid, no tiles should move and the board must remain unchanged.
 1. If the move is valid, we must swap the `EMPTY_TILE` with the selected tile.
 1. Once the swap is complete, we must check if the user has won.
 1. If the user won, we should congratulate them via a `print()`!
 1. Finally, we should return the modified game board.

 Below, write the implementation to slide a tile by translating the above pseudocode into a new function that you write from scratch, with the below constraints on the signature.
 
 * The function must be named `slideTile`
 * The function must accept two parameters: A tile value and a board of type `TilePositions`.
 * The function must return a board of type `TilePositions`, either modified (if a tile can be swapped) or unmodified (if the tile cannot be swapped).

 */
/* slideTile(_:board:)
 * Given a board and a tile value, will return a modified
 * board with that tile swapped with the empty tile, if
 * the move is valid. If invalid, the board will be
 * returned unmodified.
 */
/* TODO */

// The below should change the board and swap the `11` tile with the empty
// board = slideTile(11, board)
// TODO, do lots of tests with your slideTile() function


/*:
 
 -----
 
 ## Tying it all together

 Since we're going to use a board represented by `TilePositions` during game play, but the `generate()` function you wrote earlier generates a `Tiles` board, the last thing we need to do is be sure we adapt the generated board, represented with the `Tiles` type, into a board represented by `TilePositions`. Write the below function that calls `generate()` and performs the necessary transformation to output a game board of type `TilePositions`.

 */
/* generateBoard()
 * Leverages `generate()` to create a valid,
 * playable game board of TilePositions.
 */
func generateBoard() -> TilePositions
{
    return []
}

// TODO: add tests to be sure this works
/*:
 
 ## DONE!! 🎉🎈👍
 
 Woo hoo, that's it! Nicely done. Soon we'll put all of this into an iOS app!
 
 Although the above provides the minimum amount of functionality you would need for a functional Game of Fifteen app, you may want to tackle the Hacker edition, below, to make the game even more engaging. Although we call it the "Hacker edition", if you paid close attention to the design of each of your functions, they should only need a minimal amount of modification to complete the work!

 -----
 
 ## Hacker Edition
 
 An alternative version of the Game of Fifteen is the _n-puzzle_, a generalized form of the game. In this form, a 15-puzzle is exactly identical to (and in fact, the term is interchangeable with) the Game of Fifteen we've been discussing. A 3-puzzle has the same mechanics but with a 2x2 board. 8-puzzle has a 3x3 board, and so on. It can work with any perfect square.
 
 For an added challenge, adapt all of the functions you wrote for a two-dimensional board to work with any n-puzzle. Use the `EMPTY_TILE` constant to describe the size of the board. If that constant is changed to 4, for instance, the functions should work for a 3-puzzle and the tile numbered `3` becomes the empty tile. Every function you wrote should function in the expected manner: board generation should create a 2x2 board, tile swapping should continue to function as specified, board printing must be correct, _etc_. Supporting this version is precisely why we had the constant `EMPTY_TILE`, as opposed to hard-coding its value everywhere!
 
 Your task will be to figure out how to change all of the functions (without changing their signatures!) to work in the general case.
 
If you implemented `isBoardSolvable()` and you decide to make the modifications for this general case, carefully test your solution against a variety of board sizes. Not all solvability checking algorithms support the general n-puzzle.
 
 If you decide to make these modifications, you will easily be able to support an "Easy" (8-puzzle), "Medium" (15-puzzle), and "Hard" (24-puzzle) mode in your future iOS app!
 
 */
