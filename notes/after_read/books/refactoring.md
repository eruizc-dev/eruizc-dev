# Refactoring - Martin Fowler

It's even got his web page: <https://refactoring.com>

It's a book worth reading. It follows the same format as [[Design Patterns]]
with half the book being an explanaton on what it is, why it matters, and how
it's done while the other half is about different refactorings including
motivations, procedures and simplified examples.

The first part of the book was amazing, I've learned a lot of concepts and
referred to it a couple times when doing something at work.

The second part was rough to read, ended up skipping the entire procedure of
each refactoring. I focused on what and why, and decided to come back whenever I
need the how.

### Favquotes

 - Any fool can write code that a computer can understand. Good programmers write
code that humans can understand.

### Concepts

Refactoring
 - The modification of the underlaying code without altering its external
   behavior.

Bad Smells
 - Fowler introduces the concept of 'Bad Smells in code': things that when you
   see them you head starts to doubt. That's a sign the code is not clear, it's
   ambiguous and it should be improved in legibility.

Automated Testing
 - It is a **must** to ensure the code doesn't change its behavior. More
   [here](https://martinfowler.com/bliki/SelfTestingCode.html).

Design Stamina Hypothesis [mf-dsh]:
 - By putting our effort into a good internal design, we increase the stamina of
  the software effort, allowing us to go faster for longer.

Branch by Abstraction [mf-bba]:
 - When you need to make a big change, separate it into small steps everyone
   does whenever they happen to be close to that code. In the long term, the
   change will be effective.

### Interesting Bibliography

 - Design Patterns - GO4
 - Refactoring Databases - Scott W. Ambler and Pramod J. Sadalage.
 - Extreme Programming Explained - Kent Beck
 - Working Effectively with Legacy Code - Michael Feathers
