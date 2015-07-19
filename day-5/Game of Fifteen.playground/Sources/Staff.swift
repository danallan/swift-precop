/* Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Staff-supplied (hidden) functions for game of fifteen exercises.
 */


public class Staff {

    /*
     * Accepts two parameters; 2-tuples of ints, and
     * computes the manhattan distance between the points
     */
    private static func tileDist(a: (x: Int, y: Int), b: (x: Int, y: Int)) -> Int
    {
        return abs(a.x - b.x) + abs(a.y - b.y)
    }

    /* sign()
     * Finds the sign of the permutation of the board.
     * from: http://cseweb.ucsd.edu/~ccalabro/essays/15_puzzle.pdf
     * parameter a: [Int] (tiles themselves are 0-indexed, with empty being max)
     * returns 1 if odd, 0 if even
     */
    private static fund sign(var a: [Int]) -> Int
    {
        var s = 0, i = 0, tmp: Int
        
        while i < a.count
        {
            if i != a[i]
            {
                tmp = a[i]
                a[i] = a[tmp]
                a[tmp] = tmp
                s = 1 - s
            }
            else
            {
                i++
            }
        }
        return s
    }

    /* isBoardSolvable
     * accepts a 2d board, massages it for _sign(), locates empty
     * tile and ensures sign of the permutation of the board matches
     * the sign of the distance of the empty tile.
     * Returns true if a board is solvable, false otherwise.
     */
    public static func isBoardSolvable(board: [[Int]]) -> Bool
    {
        // flatten 2d array into 1d
        var flattened = board.flatMap({ $0 }).map({ $0 - 1 })
        
        // look for empty tile in each row
        for row in 0 ..< board.count
        {
            if let col = find(board[row], EMPTY_TILE)
            {
                // compute empty tile's distance to its final location
                let empty = (x: row, y: col)
                let last = (x: board.count-1, y: board[row].count-1)
                let dist = Staff.tileDist(empty, last)
                
                // puzzle is valid if sign of the permutation matches that of empty dist
                return Staff.sign(flattened) == (dist % 2)
            }
        }

        // if we're here, we couldn't find empty :(
        return false
    }
}
