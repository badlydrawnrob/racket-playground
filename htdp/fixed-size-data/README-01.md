# Steps

> Write as if you're stupid
> To your stupid future self

Aim to reduce human error. Don't make me think!


## Step 1

1. What is the problem question?
2. Chunk it into component parts (questions/output)
3. Create one function per task
4. Simplify! (KISS, ACID, DRY)


## Step 2

> For every constant mentioned in a problem statement,
> introduce one constant definition.


## Step 3
https://bit.ly/2ufB39f

1. Object (thing)
2. Data (representation of object)
3. Program (interpret data)


## Step 4
https://bit.ly/2FbVzwA

Big bang example — order matters!

```
(define (main y)              expression -> Master function
  (big-bang y                  expression -> big-bang -> initial state
    [on-tick sub1]             Event handler -> transform state
    [stop-when zero?]          End program
    [to-draw render-function]  Event handler -> render state
    [on-key stop-function]))   Event handler -> end program
```

## Step 5

1. Data definitions (how you're representing information)
2. Function signature, statement of purpose, function header
    — inputs consumed, outputs produced
    - what does the function compute?
    - Give it a name, paramaters and dummy output (stub, definititon type)
3. Illustrate the function with some examples
4. Take inventory. What do we need to do to make it work?
    - Make a basic template 
5. Build the function as described above
6. Test the function works
    - errors: check examples are correct
              check for logical errors in function

```
; String -> String
; Produces a duplicate string with first character removed
; given: "scrumptious", expected: "crumptious"
; (define (string-rest string) "") — stub
(define (string-rest string)
  (substring string 1))

(check-expect (string-rest "scrumptious") "crumptious" )
```

## Step 6

- It may be helpful to keep a wish list of needed functions:
    - Meaningful name for the function
    - Signature and purpose statement
- Start with the main function
    - Then pick a wish and get building!
    - Remove wish from list once completed
