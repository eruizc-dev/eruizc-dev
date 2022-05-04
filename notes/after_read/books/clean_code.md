# Clean Code - Robert C. Martin (Uncle Bob)

### What I want to achieve by reading this

- Pay Uncle Bob what I owe from [these YouTube series](https://youtu.be/7EmboKQH8lM).
- Embrace again the concepts of those videos almost one year later.
- Improve code readability.
- Adopt testing as a fundamental part of development.
- Embrace TDD.
- Get used to read books and write notes down.
- Learn how to get the most out of books I read.

### Hightlights

1. WTFs per minute:

![WTFs/minute](./resources/wtf_per_minute.jpg)

2. Clean code is *focused*. Each function, each class, each module exposes a
   single-minded attitude that remains entirely undistracted, and unpolluted,
   by the surrounding details.

3. One method that says more clearly what it does, and some submethods saying
   how it is done. [11]

### What did I got from this book


### Random ideas

- Pages in this book are in Roman. If I write a book for coders I'd use binary.
- Forget about binary, that's for machines. Programmers use base 8 and 16.

#### There will be code

Languages may be more abstract to get closer to requirements but if even humans
can't make programs that exactly match the vaguely words specified in the requirements
computers also won't. There will always be the necessity to write code to meet the
precision required by the computer to operate.

### Writing names

It was shorter than I expected, he sais more in the video series I linked earlier.

 - Use meaninfull names (`elapsedDays` instead of `d`)
 - Don't include unnecessary info (`class Account` instead of `class AccountInfo`)
 - Avoid ambiguation (`getAccount()` `getAccountInfo()`)
 - Keep class names short
 - Keep public function/method names short
 - Keep private function/method names long
 - Keep variable names be as long as their scope is

### Error handling

 - Error handling is ONE thing, so a methos that does error handling shouldn't
   do anything else.
 - NEVER return null, or throw exceptions for special cases when you can return
   a default object (like an empty list or 0)
 - NEVER pass null to a method, unless you're expecting a NullPointerException

### Boundaries

 - Learning test: write test to learn new libraries, this way you not only learn
   the library (which you have to do anyways) but also have a checker in case
   the library is updated to see wether the library still behaves as you'd
   expect.
### Funny quotes

 - There can be no worse reason for using the name `c` than because `a` and `b`
   were already taken [25]

### Books I wanna read after this

 - Literate Programming, Donald E. Knuth
 - Refactoring
