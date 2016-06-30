/////////////////

//"zip" arrays function


func zip(firstArray: [Int] , with secondArray: [Int]) -> [(zeroth: Int, first: Int)]?
{
    var comboArray: [(zeroth: Int, first: Int)] = []

    if (firstArray.count != secondArray.count) || firstArray.isEmpty
    {
        return nil
    }
    
    for index in 0..<firstArray.count
    {
        comboArray.append( (firstArray[index], secondArray[index]) )
    }
    
    return comboArray
}

if let zipped = zip([1,2,3], with: [4, 5, 6])
{
    zipped
}
else
{
    print("No zip output!")
}
