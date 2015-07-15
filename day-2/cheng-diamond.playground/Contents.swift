/* cheng */

func diamond(input: Int)
{
    /* dirty conversion to nearest higher odd number */
    let rows = input / 2 * 2 + 1
    
    for i in 0 ..< rows
    {
        for s in 0 ..< abs(rows / 2 - i)
        {
            print(" ")
        }
        for h in abs(rows / 2 - i) ..< rows - abs(rows / 2 - i)
        {
            print("*")
        }
        println()
    }
}

// test the diamond function for many sizes!
for i in 0...12
{
    println("Diamond of size \(i):\n")
    diamond(i)
    println("\n")
}