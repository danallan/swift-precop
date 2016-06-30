/*:
 
 # Obfuscated Swap
 
 This swap function is implemented with generics, but we've written it in a way that makes it quite hard to read! This is a perfect example of how not to write code, though the implications (the fact that we can use Unicode characters for identifiers) is advantageous for programmers whose native language is not English.
 
 Takeaways, regardless of the poor style, include:
 1. The use of the `inout` keyword to modify the variables passed from outside the scope of the function, and the requisite use of `&` when calling the function to allow those variables to be changed in the function.
 2. Generic types to support swapping any two variables that are of some (same) type.
 
 Try de-obfuscating this code to improve its readability.
 */
func 🔃<🖖>(inout 💵: 🖖, inout 🎈 🚆: 🖖)
{
    let 🎯: 🖖 = 💵
    💵 = 🚆
    🚆 = 🎯
}

var 🍩 = "🍏"
var 🐑 = "🍎"

🔃(&🐑, 🎈: &🍩)

🍩
🐑
