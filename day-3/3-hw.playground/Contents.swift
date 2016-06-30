/*:

 # Day 3 Homework
 
 ## Problem 1: Generic `zip`
 
 Take one of your prior implementations of `zip` (either the one that returns an optional array, or one that returns an array of tuples of optional values) and adapt it to be fully generic.
 
 */
// your generic zip here!
/*:
 
 ## Problem 2: Caesar
 
 Given a string and an integer key, print the encrypted string using a [Caesar cipher](https://en.wikipedia.org/wiki/Caesar_cipher).
 
 Encryption is particularly important in computer science. For example, if you want to enter a password or credit card number on a website, you wouldn't want other people reading that information while it's being sent! Encryption modifies that data so people (other than the intended recipient) can't read it (at least, in theory).
 
 Normally, encrypted data can be decrypted using a key, or a piece of data that the intended recipient has access to.
 
 The Caesar algorithm is one of the earliest ways to encrypt text and is now regarded as quite insecure. It takes an integer key and a string of non-accented English characters (A to Z), and rotates each letter in the string by the key.
 
```
caesar("ABBCCC", 1); // Should print "BCCDDD"
caesar("Danana", 1); // Should print "Ebobob"
```
 
 Before you get started, a few things to keep in mind:
 1. If the user inputs 0 or 26 as the key, the encrypted string should be the same as the original string.
 2. The function should be able to handle keys that are outside of the range 0-26. For example, if the user inputs `hi` and 28, the output should be `jk`.
 3. Only alphabetical characters should be rotated; everything else (spaces, numbers, etc.) should remain the same.
 
 Hints:
 1. Strings have a [property](https://developer.apple.com/library/ios/documentation/Swift/Reference/Swift_String_Structure/index.html#//apple_ref/swift/structp/String/s:vSS14unicodeScalarsVSS17UnicodeScalarView), `.unicodeScalars`, which you can iterate over to fetch individual values of every code point.
 1. You can create a Unicode Scalar of your own with `UnicodeScalar()`, which accepts a `UInt32` as a parameter.
 1. You can build a string out of individual Unicode Scalars with `.append()`.
*/
func caesar(plaintext: String, key: UInt32) -> String
{
    return ""
}

print(caesar("Hello, world!", key: 1))
print(caesar("Dan, Hari, Annie, Jack, Stelios, AJ", key: 5))
print(caesar("caf\u{E9}", key: 2))
print(caesar("caf\u{65}\u{301}", key: 26))
print(caesar("The quick brown fox jumps over the lazy dog.", key: 13))
print(caesar("This is a real sentence made with caesar salad. 🍓", key: 1234))
// add more tests
/*:
 
 ## Problem 3: Vigenère (optional)

 As you can imagine, you can trivially determine the key used in a Caesar cipher by simply generating all 26 possible string rotations, and see which one makes sense. Not super secure!
 
 We could increase the complexity by having one key per letter of the plaintext. For example, imagine that we have the string "Swift" and an array of integers `[1, 2, 3, 4, 5]`. We would rotate the first letter in the plaintext, `S`, by 1, the `w` by 2, and so on. This would result in an encrypted ciphertext of `Tyljy`. A little harder to crack! But only a little.
 
 Now, imagine that this array of integers was generated from an array of Characters, or perhaps more generally, a String. For example, the plaintext `Swift` encrypted with the key `ABCDE` would be `Fkxvk`! In essence, the key `ABCDE` is equivalent to the array of integers `[65, 66, 67, 68, 69]`. This is the idea behind the [Vigenère cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher). Note that what we are implementing is not a *true* Vigenère cipher, since normally a key of "A" would not actually rotate the string, but doing it this way enables us to use any Unicode character as a key, including emoji!
 
 Write a function, `vigenère`, below, to do precisely this. Here are some hints!
 
 1. As with Caesar, you can transform the Unicode sequence into `UInt32` values using `key.unicodeScalars`.
 2. If you run out of Unicode scalars in the key before you run out of characters in the plaintext, you should wrap around and start from the first index of the key again.
 3. If the key is empty, return the plaintext as there is nothing to do.
 4. Check it out! Now you can "encrypt" (albeit insecurely) with a string of emojis!
 */
func vigenère(plaintext: String, key: String) -> String
{
    return ""
}

print(vigenère("Swift", key: "ABCDE"))
print(vigenère("iOS", key: "📱📲"))
// add many more tests!
/*:
 
 Although you don't need to write any code, think about what you would have to do to decrypt these strings!
 */

