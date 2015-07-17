/*

Problem 4 - Caesar

Given a string and an integer key, print the encrypted string.

Um... what?

Encryption is particularly important in computer science. For example, if you want to enter a password or credit card number on a website, you wouldn't want other people reading that information while it's being sent, would you? Encryption modifies that data so people (other than the intended recipient) can't read it (at least, in theory).

Normally, encrypted data can be decrypted using a key, or a piece of data that the intended recipient has access to.

The Caesar algorithm is a simple (albeit not very secure) way to encrypt text. It takes a string and an integer key, and it rotates each letter in the string by the key.

For example:

caesar("ABBCCC", 1); // Should print "BCCDDD"
caesar("Danana", 1); // Should print "Ebobob"

Before you get started, a few things to keep in mind:
    0) If the user inputs 0 or 26 as the key, the encrypted string should be the
       same as the original string.
    1) The function should be able to handle keys that are outside of the range
       0-26. For example, if the user inputs "hi" and 28, the output should be
       "jk".
    2) Only alphabetical characters should be rotated; everything else (spaces,
       numbers, etc.) should remain the same.

Hint: remember your printASCII() function that you wrote in previous exercises? Copy it here, rename it "convertToInts(str: String) -> [Int]", and modify it to do exactly that: given a string, return a list of Ints representing the ASCII values.

When you're done with this, try a challenge! Implement a Vigenère cipher:
https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

*/

/*
 * convertToInts takes a string and returns a list of Ints
 * representing the ASCII values of the individual characters
 * of that string.
 */
func convertToInts(str: String) -> [Int]
{
    /* TODO */
    return []
}

func caesar(string: String, key: Int)
{
    println("TODO")
}

caesar("ABCDWXYZ", 1)
caesar("ABCDWXYZ", 2)
caesar("Danana", 1)
caesar("This is a real sentence made with caesar salad.", 1234)

