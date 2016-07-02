/* Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Staff-supplied (hidden) functions for game of fifteen exercises.
 */

import Darwin

public class Staff {
    
    /* sign()
     * Finds the sign of the permutation of the board.
     * from: http://cseweb.ucsd.edu/~ccalabro/essays/15_puzzle.pdf
     * parameter a: [Int] tiles numbered sequentially, [0,board.length),
     *                    with empty at board.length-1
     * returns 1 if odd, 0 if even
     */
    private static func sign(a: [Int]) -> Int
    {
        var a = a // make board mutable
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
                i += 1
            }
        }
        return s
    }
    
    /* isBoardSolvable
     * accepts a board with tiles from [1, board.count], massages it for
     * _sign() by converting tiles to [0, board.count), locates the empty
     * tile and ensures the sign of the permutation of the board matches
     * the sign of the distance of the empty tile. Returns true if board
     * is solvable, false otherwise.
     */
    public static func isBoardSolvable(board: [Int]) -> Bool?
    {
        // the width and height of the board
        let size = Int(sqrt(Double(board.count)))
        let boardSign = self.sign(board) % 2

        // odd-width boards are solvable if sign is even
        if size % 2 == 1
        {
            return boardSign == 0
        }
        
        // even-width boards
        if let index = board.indexOf(board.count - 1)
        {
            // is empty in an odd row from bottom
            let emptyRowSign = (index / size) % 2

            // puzzle validity for even width puzzles
            return emptyRowSign != boardSign
        }
        
        // if we're here, we couldn't find empty tile :(
        print("STAFF: Could not find empty tile")
        return nil
    }
    
    /*
     * isBoardSolvable() for two-dimensional boards.
     */
    public static func isBoardSolvable(board: [[Int]]) -> Bool?
    {
        // flatten the board to a 1d array
        return self.isBoardSolvable(board.flatMap({ $0 }))
    }
    
}
