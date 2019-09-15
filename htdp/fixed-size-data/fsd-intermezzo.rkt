;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-intermezzo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Intermezzo 1: Beginning Student Language
;;;; ========================================
;;;;
;;;; #!: Use the stepper when you don't understand!
;;;; #!: Use the stepper to double check result!
;;;; #!: Use the stepper to double check new grammar!
;;;; #!: Use the stepper to debug errors!
;;;;
;;;; #!: If a program encounters an error,
;;;;     it will stop working past that point.
;;;;
;;;;
;;;; (function argument ... argument)
;;;;
;;;; (define (function-name param ... param) — or attributes?
;;;;   function-body)
;;;;
;;;; (cond
;;;;   cond-clause
;;;;   ...)
;;;;
;;;; cond clause
;;;; [condition answer]


;;; Exercises

;; 116
; 1. variable
; 2. Keyword is to left of the expression
; 3. ""

;; 117
; 1. Keyword is in wrong position
; 2. No brackets for keyword
; 3. Variable is not allowed in brackets without keyword in front

;; 118
; 1. Keyword at start, followed by name and attribute in brackets, then expression (body)
; 2. Same, with a different body (function attribute is not used)
; 3. Two function attributes and a value as the body

;; 119
; 1. String not allowed in function head
; 2. Variable not allowed without function keyword

;; 120
; 1. bullshit
; 2. expression works, bullshit value (wrong value in expression)
; 3. expression works


;; 121

; 1.

(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))

; ==
; (+ (* 1.5 2/3)
;    (- 20 2))
; ==
; (+ 1 18)
; ==
; 19

; 2.

(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/ 1 0) 9)])

; ==
; (cond
;   [#true #false]
;   [(> 0 1) (string=? "a" "a")]
;   [else (= (/ 1 0) 9)])
; == ; by rule cond true
; #false

; 3.

(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])

; ==
; (cond
;   [#false #false]
;   [(> 2 1) (string=? "a" "a")]
;   [else (= (/ 1 2) 9)])
; == ; by rule cond false
; (cond
;   ; remove line
;   [#true (string=? "a" "a")]
;   [else (= (/ 1 2) 9)])
; == ; by rule cond true
; (string=? "a" "a")
; ==
; #true


;; Exercise 122

(define (f x y)
  (+ (* 3 x) (* y y)))

; 1.

(+ (f 1 2) (f 2 1))

; ==
; (+ (+ (* 3 1) (* 2 2))
;    (f 2 1))
; ==
; (+ (+ 3 4)
;    (f 2 1))
; ==
; (+ 7
;    (f 2 1))
; ==
; (+ 7
;    (+ (* 3 2) (* 1 1)))
; ==
; (+ 7
;    (+ 6 1))
; ==
; (+ 7 7)
; ==
; 14

; 2. Can't be arsed

(f 1 (* 2 3))  ; 39

; 3. Can't be arsed

(f (f 1 (* 2 3)) 19) ; (f 39 19) -> (+ 117 361) -> 478




;;; Errors
;;; ------

; #! division by zero
; (/ 1 0)



;;; Conditions
;;; ----------

;; (and exp-1 exp-2)	

; is short for
;
; (cond
;   [exp-1 exp-2]
;   [else #false])


;; (or exp-1 exp-2)	

; is short for
;
; (cond
;   [exp-1 #true]
;   [else exp-2])



;;; Exercise 123
;;; ------------

;; (if exp-test exp-then exp-else)

; is short for
;
; (cond
;   [exp-test exp-then]
;   [else exp-else])



;;; Exercise 124
;;; ------------

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))

; (define PRICE 5)
; (define SALES-TAX 0.4)
; (define TOTAL 5.4)

(define COLD-F 32)
(define (fahrenheit->celsius f)
  (* 5/9 (- f 32)))
(define COLD-C (fahrenheit->celsius COLD-F))


; (define COLD-F 32)
; (define COLD-C ...)
; ==
; (farenheight->celsius (* 5/9 (- 32 32)))
; ==
; (farenheight->celsius (* 5/9 0))
; ==
; it's fine

(define LEFT -100)
(define RIGHT 100)
(define (f2 x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f2 LEFT))
(define f@RIGHT (f2 RIGHT))

; (define LEFT -100)
; (define RIGHT 100)
; (define (f2 x) ...)
; (define f@LEFT ...)
; ==
; (f -100)
; ==
; (+ (* 5 (expt -100 2)) 10)
; ==
; (+ (* 5 10000) 10)
; ==
; (+ 50000 10)
; ==
; 50010
; (define f@RIGHT ...)
; ==
; (f 100)
; ==
; (+ (* 5 (expt 100 2)) 10)
; ==
; (+ (* 5 10000) 10)
; ==
; (+ 50000 10)
; ==
; 50010




;;; Exercise 125
;;; ------------

; 1.
(define-struct oops []) ; legal, but why would you use this?
; 2.
(define-struct child [parents dob date]) ; legal
; 3.
; (define-struct (child person) [dob date]) ; illegal



;;; Exercise 126
;;; ------------

(define-struct point [x y z])
(define-struct none [])

; 1.
(make-point 1 2 3)
; x == 1, y == 2, z == 3

; 2.
(make-point (make-point 1 2 3) 4 5)
; x == point, y == 4, z == 3

; 3.
(make-point (+ 1 2) 3 4)
; x == 3, y == 3, z == 4

; 4.
(make-none)
; (make-none)

; 5.
(make-point (point-x (make-point 1 2 3)) 4 5)
; x == 1, y == 4, z == 5



;;; Exercise 127
;;; ------------

(define-struct ball [x y speed-x speed-y])

; can't be arsed

; 1. #false
; 2. 3
; 3. 6
; 4. error
; 5. error



;;; Exercise 128
;;; ------------
 
; (check-member-of "green" "red" "yellow" "grey")  ; green isn't there
; (check-within (make-posn #i1.0 #i1.1)            ; values are different
;               (make-posn #i0.9 #i1.2)  0.01)
; (check-range #i0.9 #i0.6 #i0.8)                  ; out of range
; (check-random (make-posn (random 3) (random 9))
;               (make-posn (random 9) (random 3))) ; not equal (reversed places)
; (check-satisfied 4 odd?)                         ; even number

(check-member-of "green" "yellow" "red" "green")
(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2) 0.2)
(check-range #i0.7 #i0.6 #i0.8)
(check-random (make-posn (random 3) (random 9))
              (make-posn (random 3) (random 9)))
(check-satisfied 3 odd?)




;;; BSL Error messages
;;; ------------------
;;; Some messages can be criptic, for instance
;;; you've missed out the brackets in the conditional
;;; or fudged more than one expression

(define (absolute n)
  (cond
    [< 0 (- n)] ; missing an opening "(", and more ...
    [else n]))



(f3 1)
; f3: this function is not defined

(1 3 "three" #true)
; function call: expected a function after the open parenthesis,
; but found a number

(average 7)
; average: expects 2 arguments, but found only 1

(average 1 2 3)
; average: expects 2 arguments, but found 3

(make-posn 1)
; make-posn: expects 2 arguments, but found only 1

(posn-x #true)
; posn-x: expects a posn, given #true

(average "one" "two")
; +: expects a number as 1st argument, given "one"

(cond
  [(>= 0-to-9 5)])
; cond: expected a clause with a question and an answer,
; but found a clause with only one part

(cond
  [(>= 0-to-9 5)
   "head"
   "tail"])
; cond: expected a clause with a question and an answer,
; but found a clause with 3 parts

(cond)
; cond: expected a clause after cond, but nothing’s there

(define f(x) x)
; define: expected only one expression after the variable name f,
; but found 1 extra part

(define (f x x) x)
; define: found a variable that is used more than once: x

(define (g) x)
; define: expected at least one variable after the function name,
; but found none

(define (f (x)) x)
; define: expected a variable, but found a part

(define (h x y) x y)
; define: expected only one expression for the function body,
; but found 1 extra part

(define-struct [x])
(define-struct [x y])
; define-struct: expected the structure name after define-struct,
; but found a part

(define-struct x
  [y y])
; define-struct: found a field name that is used more than once: y

(define-struct x y)
(define-struct x y z)
; define-struct: expected at least one field name (in parentheses)
; after the structure name, but found something else