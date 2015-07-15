// Dan Armendariz
// danallan@cs.harvard.edu
//
// Diamonds!!

let MAX_SIZE = 40

for line in 0 ..< MAX_SIZE
{
    var line_size = line + 1
    if (line > MAX_SIZE/2)
    {
        line_size = MAX_SIZE - line
    }
    
    for space in 1 ... (MAX_SIZE-line_size)
    {
        print(" ")
    }
    
    for star in 1 ... (2*line_size-1)
    {
        print("*")
    }
    
    // go to next line
    println()
}






















