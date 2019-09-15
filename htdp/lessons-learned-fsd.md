# Lessons Learned
## Fixed Size Data

In this first part of the book, you learned a bunch of simple but important lessons. Here is a summary:

### 1. A good programmer designs programs

A bad programmer tinkers until the program seems to work.

### 2. The design recipe has two dimensions

One concerns the process of design, that is, the sequence of steps to be taken. The other explains how the chosen data representation influences the design process.

### 3. Every well-designed program consists of ...

Many constant definitions, structure type definitions, data definitions, and function definitions. For batch programs, one function is the “main” function, and it typically composes several other functions to perform its computation. For interactive programs, the big-bang function plays the role of the main function; it specifies the initial state of the program, an image-producing output function, and at most three event handlers: one for clock ticks, one for mouse clicks, and one for key events. In both kinds of programs, function definitions are presented “top down,” starting with the main function, followed by those functions mentioned in the main function, and so on.

### 4. Like all programming languages ...

Beginning Student Language comes with a vocabulary and a grammar. Programmers must be able to determine the meaning of each sentence in a language so that they can anticipate how the program performs its computation when given an input. The following intermezzo explains this idea in detail.

### 5. Programming languages, including BSL ...

Come with a rich set of libraries so that programmers don’t have to reinvent the wheel all the time. A programmer should become comfortable with the functions that a library provides, especially their signatures and purpose statements. Doing so simplifies life.

### A programmer must get to know the “tools” ...

That a chosen programming language offers. These tools are either part of the language—such as cond or max—or they are “imported” from a library. In this spirit, make sure you understand the following terms: structure type definition, function definition, constant definition, structure instance, data definition, big-bang, and event-handling function.