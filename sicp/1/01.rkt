#lang sicp

;; 1.1.6 =========================================================

;; General form of a procedure definition
;; “(define (⟨name⟩ ⟨formal parameters⟩) ⟨body⟩)”

;; Conditional expressions and predicates
;; Each condition runs until returns #t

(define (abs x)
  (cond ((> x 0) x)
        ((= 0 x) 0)
        ((< x 0) (- x))))

;; A shortened version of above
(define (abs-shortened x)
  (cond ((< x 0) (- x))
        (else x)))

;;; Alternative notation of brackets
(define (abs-brackets x)
  (cond [(< x 0) (- x)]
        [else x]))

;; Same function with an if statement
;; Use `if` when there's only two "cases" needed.
;; — unlike with Python's elif for multiple cases.
;; - You don't need the `else` here ...
(define (abs-if x)
  (if (< x 0)
      (- x)
      x))

;; Using conditional and, or, not
;; is in range, using AND
(define (in-range? x)
  (and (> x 5) (< x 10)))

(in-range? 5) ; #f
(in-range? 6) ; #t

;; OR returns true if one statement returns true
;; If the first statement returns true, the following
;; statements aren't evaluated. In left-to-right order
(define (>= x y)
  (or (> x y) (= x y)))

(>= 1 10)  ; #f
(>= 10 10) ; #t
(>= 11 10) ; #t

;; Using NOT to evaluate the same expression
;; - here we check X ISN'T less than Y ...
(define (not-less-than x y)
  (not (< x y)))

(>= 1 10)  ; #f
(>= 10 10) ; #t
(>= 11 10) ; #t


;;; Exercise 1.2 ==============================================

(/ (+ 5 4
      (- 2
         (- 3 (+ 6 (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))


;;; Exercise 1.4 ==============================================
;;
;; I think what this function does is return a `+`
;; if b is a positive number, or a `-` if it's below zero.
;; If statement returns the operator to act on `a` and `b`
;; - 🤔 negative negatives still fuck up my brain.
;; - 🔗 https://www.mathsisfun.com/multiplying-negatives.html
;; - 🔗 http://tinyurl.com/54tt7xvb (ELi5)

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 1 2)   ; 3
(a-plus-abs-b -1 2)  ; 1
(a-plus-abs-b 1 -1)  ; 2
(a-plus-abs-b -1 -1) ; 0


;;; Exercise 1.5 ===============================================
;;
;; ⚠️ See README for applicative- vs normal-order evaluation,
;; and explaination of the infinite loop that (test 0 (p)) will cause.

(define (p) (p))

(define (test x y)
  (if (= x 0) 0
      y))

;; An infinite loop if this runs:
; (test 0 (p))



;;; 1.1.7 =====================================================

;; Square roots by Newton's method
;; Pseudo lisp to showing a problem that describes 'what it is',
;; but not how to compute it. It shows the property of a thing,
;; not the 'how to' of the thing.

; (define (sqrt x)
;   (the y (and (>= y 0)
;               (= (square y) x))))

;; Whenever we have a guess for y for the value of the square
;; root of a number x, we can perform a simple manipulation to
;; get a better guess (one closer to the actual square root)
;; by averaging y with x/y. For example, we can compute the
;; square root of 2 as follows. Suppose our initial guess is 1:
;;
;; - https://www.cuemath.com/numbers/quotient/

; guess    quotient     average
;
; <guess>  (2/<guess>)  ((2 + <guess>) / 2)
;
; 1        (2/1)        ((2 + 1) / 2)
;            = 2           =  1.5
;
; 1.5      (2/1.5)      ((1.3333 + 1.5) / 2)
;            = 1.3333     = 1.4167
;
; 1.4167    ...         ...


;; WISHFUL THINKING:
;;
;; From our table, we can formalize the process with a procedure.
;; We use 'wishful thinking' to make a start on our function ...
;;
;; - A little bit like HTDP function recipe, but we're writing
;;   out the template function as if the child functions already exist,
;;   without worrying yet HOW to compute them. (see README)

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

;; Now continue to flesh out the child functions ...

(define (improve guess x)
  (average guess (/ x guess)))

;; Now we need the average function to make `improve` work ...

(define (average x y)
  (/ (+ x y) 2))

;; Let's test those two functions:

(average 1 2) ; => 1.5
(improve 1 2) ; => (average 1 (/ 2 1)) => (average 1 2) => ...


;; `sqrt-iter` still won't run until we've declared
;; the `good-enough?` function
;;
;; “The idea is to improve the answer until it is close
;; enough so that its square differs from the radicand by less than a
;; predetermined tolerance (here 0.001)”
;;
;; - https://www.mathsisfun.com/definitions/radicand.html

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; We also need the `square` function to use `good-enough?`

(define (square n)
  (* n n))

(square 2) ; => 4

;; Now we can run the `good-enough?` function ...

(good-enough? 1 2)            ; => . (square 1) . => . (- 1 2) . => . (abs -1) . => (< 1 0.001) => #f
(good-enough? 1.5 2)          ; => #f
(good-enough? 1.4142135624 2) ; => #t


;; And finally run the whole damn thing ...

(sqrt-iter 1 2) ; => 1.5 => 1.4167 => ... so on ...


;; Wrap it all up in a better function name:
;;
;; let's set the guess always starting at `1.0`
;; - Using a floating point number returns a floating point (not a mixed fraction)

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9) ; => 3.00009155413138


;;; Exercise 1.6 =================================================================
;;
;; Alyssa P. Hacker doesn’t see why if needs to be provided as a special form.
;; “Why can’t I just define it as an ordinary procedure in terms of cond?”

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5) ; => 5
(new-if (= 2 2) 0 5) ; => 0

;; “Delighted, Alyssa uses new-if to rewrite the square-root program:”

(define (sqrt-iter-new-if guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter-new-if (improve guess x) x)))

;; Alyssa realises that running this function creates an infinite loop:
;; - http://community.schemewiki.org/?sicp-ex-1.6
;;
;; Only one of the two consequent expressions get evaluated when using `if`,
;; while both of the consequent expressions get evaluated with `new-if`.
;;
;; See file `excercise-1.1.6-infinite-loop.rkt`


;;; ⚠️ Exercise 1.7 =================================================================
;;
;; I'm not sure how to change the function for these fringe cases.
;; - http://community.schemewiki.org/?sicp-ex-1.7
;;
;; `good-enough?` test won't be very effective for very small, or very large numbers.
;; — the numbers below don't match up!!


(sqrt 0.00023)               ; => 0.03366344048109187
(square 0.03366344048109187) ; => 0.001133227225024015


;;; ⚠️ Exercise 1.8 =================================================================
;;