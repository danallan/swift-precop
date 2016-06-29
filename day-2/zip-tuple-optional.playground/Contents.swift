/////////////////

//"zip" arrays function


func printGradeCount(gradebook: [String:[Int]])
{
    for (key, val) in gradebook
    {
        print("\(key) has \(val.count) items")
    }

    
    if let exams = gradebook["exam"]
    {
        print("exams has \(exams.count)")
    }
    else{
        print("no exams :(")
    }
}

func zip(first: [Int], with second: [Int]) -> [(Int?, Int?)]
{
    let maxSize = max(first.count, second.count)
    var result = [(Int?, Int?)](count: maxSize, repeatedValue: (nil, nil))
    
    for (i, lel) in first.enumerate()
    {
        result[i] = (lel, nil)
    }
    for (j, rel) in second.enumerate()
    {
        result[j] = (result[j].0, rel)
    }

    return result
}

zip([1, 2, 3], with: [4, 5])
zip([1, 2, 3], with: [4, 5, 6, 7])
