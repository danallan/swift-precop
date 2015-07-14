/*
 * Dan Armendariz
 * danallan@cs.harvard.edu
 *
 * Types in Swift
 *
 */

// Up until now, we've allowed Swift to infer types. But we can be explicit!
let name: String = "Dan"

// We can "concatenate" strings: or combine two of them together
var label: String = "Hello, " + name

// If you create a variable and don't assign it a variable, you must provide a type
var grade: Int

// when we assign data to it, it must match the type
grade = 100

// update the label variable: but the commented line below will error; why?
// label = "Your grade is: " + grade
// The types don't match! Swift is strongly statically typed, and will not
// allow us to convert (or "cast") one type to another implicitly.

// The this will work; an explicit typecast
label = "Your grade is: " + String(grade)

// A decimal value is called a "double"
var gpa: Double = 3.5

// We have also seen or discussed the below. "Bool" is short for "Boolean"
var won: Bool = false

// We can also have individual characters
var letter: Character = "a"

// you can do this, but do you REALLY want to
var 💩: String = "poo"

// We've already seen strings. If you were a programmer, 
// how would you create a string?
