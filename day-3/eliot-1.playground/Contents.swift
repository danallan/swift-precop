/* cheng */


/* ELIOT 1 */


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 1      Say hello

        Print "Hello, world!" to the screen.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func hello()
{
    /* TODO */
}

println("1      Say hello\n")
hello() /* Should print "Hello, world!" */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
2      Say personal hello

       Print "Hello, cheng!", where "cheng" is any name, using the
       variable name.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func personal_hello(name: String)
{
    /* TODO */
}

println("2      Say personal hello\n")
personal_hello("cheng")     /* Should print "Hello, cheng!"     */
personal_hello("your name") /* Should print "Hello, your name!" */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
3      Say secret hello

       Print "Hello, cheng!", where "cheng" is any name, except for
       "Dan", who gets the greeting "Sup Dan!".
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func secret_hello(name: String)
{
    /* TODO */
}

println("3      Say secret hello\n")
secret_hello("cheng")       /* Should print "Hello, cheng!"     */
secret_hello("your name")   /* Should print "Hello, your name!" */
secret_hello("Dan")         /* Should print "Sup Dan!"          */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
4      Some sum
       Add up all the numbers from 1 to n, and print it.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func some_sum(n: Int)
{
    /* TODO */
}

println("4      Some sum\n")
some_sum(0)     /* Should print "0"  */
some_sum(1)     /* Should print "1"  */
some_sum(2)     /* Should print "3"  */
some_sum(5)     /* Should print "15" */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
5      Secret sum
       Add up only the even numbers from 1 to n, and print it.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func secret_sum(n: Int)
{
    /* TODO */
}

println("5      Secret sum\n")
secret_sum(0)   /* Should print "0" */
secret_sum(1)   /* Should print "0" */
secret_sum(2)   /* Should print "2" */
secret_sum(5)   /* Should print "6" */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
6      Max value
       Print the maximum value in an array.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func max_value(array: [Int])
{
    /* TODO */
}

println("6      Max value\n")
max_value([0])                  /* Should print "0" */
max_value([0, 1])               /* Should print "1" */
max_value([1, 0])               /* Should print "1" */
max_value([1, 2, 4, 8, 0, 3])   /* Should print "8" */
println("\n")

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
7      Find value
       Print the index of the value in the array, or -1 if not there.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func find_value(value: Int, array: [Int])
{
    /* TODO */
}

println("7      Find value\n")
find_value(1, [0])                  /* Should print "-1" */
find_value(5, [3, 5])               /* Should print "1"  */
find_value(8, [1, 2, 4, 8, 0, 3])   /* Should print "3"  */
println("\n")

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
8      One line
       Print a line of n "@"s.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func one_line(n: Int)
{
    /* TODO */
}

println("8      One line\n")
one_line(0)     /* Should print nothing */
one_line(1)     /* Should print "@"     */
one_line(3)     /* Should print "@@@"   */
one_line(5)     /* Should print "@@@" */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
9      Square
       Print an n x n square of "@"s.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func square(n: Int)
{
    /* TODO */
}

println("9      Square\n")
square(0)       /* Should print nothing */
square(1)       /* Should print
                   @
                 */
square(2)       /* Should print:
                   @@
                   @@
                 */
square(5)       /* Should print:
                   @@@@@
                   @@@@@
                   @@@@@
                   @@@@@
                   @@@@@
                */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
10     Pyramid
       Print a pyramid of height n.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func pyramid(n: Int)
{
    /* TODO */
}

println("10     Pyramid\n")
pyramid(0)      /* Should print nothing */
pyramid(1)      /* Should print
                   @
                 */
pyramid(2)      /* Should print:
                   @
                   @@
                 */
pyramid(5)      /* Should print:
                   @
                   @@
                   @@@
                   @@@@
                   @@@@@
                 */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
11     Reverse pyramid
       Print a reverse pyramid of height n.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func reverse_pyramid(n: Int)
{
    /* TODO */
}

println("11     Reverse pyramid\n")
reverse_pyramid(0)      /* Should print nothing */
reverse_pyramid(1)      /* Should print
                           @
                         */
reverse_pyramid(2)      /* Should print:
                            @
                           @@
                         */
reverse_pyramid(5)      /* Should print:
                               @
                              @@
                             @@@
                            @@@@
                           @@@@@
                         */
println("\n")


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
12     Triangle
       Print a triangle of height n.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func triangle(n: Int)
{
    /* TODO */
}

println("12     Triangle\n")
triangle(0)     /* Should print nothing */
triangle(1)     /* Should print
                   @
                 */
triangle(2)     /* Should print:
                    @
                   @@@
                 */
triangle(5)     /* Should print:
                       @
                      @@@
                     @@@@@
                    @@@@@@@
                   @@@@@@@@@
                 */
println("\n")
