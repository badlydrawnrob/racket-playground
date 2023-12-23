#lang sicp

;; 1.1.6

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


;;; Exercise 1.2

(/ (+ 5 4
      (- 2
         (- 3 (+ 6 (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))

;;; Exercise 1.4
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

;;; Exercise 1.5
;; ⚠️ See README for applicative- vs normal-order evaluation,
;; and explaination of the infinite loop that (test 0 (p)) will cause.
(define (p) (p))

(define (test x y)
  (if (= x 0) 0
      y))

;; An infinite loop if this runs:
; (test 0 (p))


;;; 1.1.7

;; Square roots by Newton's method
;; Pseudo lisp to showing a problem that describes what it is,
;; but not how to compute it. It shows the property of a thing,
;; not the "how to" of the thing.

; (define (sqrt x)
;   (the y (and (>= y 0)
;               (= (square y) x))))