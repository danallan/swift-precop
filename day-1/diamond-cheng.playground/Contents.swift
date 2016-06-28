/* cheng */

func diamond(input: Int)
{
    /* dirty conversion to nearest higher odd number */
    let rows = input / 2 * 2 + 1
    
    for i in 0 ..< rows
    {
        for _ in 0 ..< abs(rows / 2 - i)
        {
            print(" ",  terminator: "")
        }
        for _ in abs(rows / 2 - i) ..< rows - abs(rows / 2 - i)
        {
            print("*", terminator: "")
        }
        print()
    }
}

// test the diamond function for many sizes!
for i in 0...12
{
    print("Diamond of size \(i):\n")
    diamond(i)
    print("\n")
}
