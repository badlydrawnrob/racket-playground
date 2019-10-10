;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9.3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.3 Natural Numbers
;;;; ===================
;;;;
;;;; 1. Sketch out the problem first,
;;;; 2. Write problem as lists->results table, or empty->full method
;;;; 3. Use design recipe
;;;; 4. Double check your base cases!
;;;; 5. Do you need to split out functions?
;;;; 6. How will you deal with empty lists?
;;;;
;;;;
;;;; ##: Beware of infinite loops!
;;;;
;;;;     Without type checking the condition as a positive number,
;;;;     the wrong type will throw a spanner in the works.
;;;;
;;;;
;;;; #1: A given natural number can match NN data definition
;;;;     here zero is considered atomic data and positive numbers
;;;;     structured values.
;;;;
;;;;     - The first condition is zero
;;;;     - (add1 ...) is a bit like (cons ...)
;;;;       - The inverse is (sub1 ...), a bit like (first ...) or (rest ...)
;;;;       - The Natural-Number is self-referential
;;;;     - You can use predicates like (zero? ...) and (positive? ...)
;;;;
;;;;     So essentially, you're creating a (cons ...) list and passing the
;;;;     function back in on itself, removing 1 from the given NN, until
;;;;     you reach zero, adding an '() to the last (cons ...) pair.
;;;;
;;;;
;;;; #2: Right now, there are no type-checks on the input, so you can
;;;;     essentially create copies of Any data-type in a list.
;;;;
;;;;
;;;; #3: You can nest (add1 ...) function like this:
;;;;
;;;;     - (add1 (add1 (add1 0))) -> 3


(require 2htdp/image)


;;; Demo
;;; ====
;;; Natural numbers in functions

; Create cons lists
; give me  x of y
(make-list 2 "hello") ; (cons "hello" (cons "hello" '()))
(make-list 3 #true)   ; (cons #t (cons #t (cons #t '())))
(make-list 0 17)      ; '()


; An Natural-Number is one of:
; - 0
; - (add1 Natural-Number)
; interpretation represents the counting numbers

; add1 -- cons
; sub1 -- first rest

; zero?  - empty?
; positive? - cons? - else


; N String -> List-of-strings
; creates a list of n copies of s

(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))

; #1
(define (copier n s)
  (cond
    [(zero? n) '()]                                ; 0
    [(positive? n) (cons s (copier (sub1 n) s))])) ; (add1 N)



;;; Exercise 149
;;; ------------
;;; Copier works for both natural numbers, boolean
;;; and image — you'd need to type-check if you wanted
;;; to limit the inputs ...

(define-struct boom [number string])
(define BOOM (make-boom 1 "there it is"))

; Natural-Number Any -> List-of-any
(copier 3 BOOM) ; #2

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))])) ; #!

;;; Always TYPE-CHECK! copier.v2 will fail ...
;;;
;;; - 0.1 ... infinite loop
;;; - "x" ... fails at (zero? ...)
;;; - -1  ... infinite loop

;;; This could be made clear by:

; A PositiveNumber is one of:
; - 0
; - (add1 PositiveNumber)



;;; Exercise 150
;;; ------------
;;; Consumes a natural number n and adds to pi
;;; without using the primitive + operation

; N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 3) (+ 3 pi) 0.001)

(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))])) ; #3

 
; '()                            -> (+ 0 pi)  -> pi
; (cons 1 '())                   -> (+ 1 pi)  -> (add1 pi)
; (cons 2 (cons 1 '()))          -> (+ 2 pi)  -> ...
; (cons 3 (cons 2 (cons 1 '()))) -> (+ 3 pi)

