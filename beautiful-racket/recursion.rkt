#lang racket

; Source material: https://beautifulracket.com/explainer/recursion.html
; Another source: https://bit.ly/2MCOkEl
; Loops vs Recursion: https://youtu.be/HXNhEYqFo0o
; Tail recursion: https://bit.ly/2Nw1rqt and https://stackoverflow.com/a/37010
; recursion for dummies: https://bit.ly/2MJXdf1
;
; #!: look up "shape of recursion" function
; #!: look up "stack overflow" for too many function calls
;     - flat
;     - diamond
;
; — Recursion AVOIDS MUTATION of values
; — Racket optimises tail calls


; Factorial
; ---------
; The first version mutates a value ...
;
; #!: infinite loop if trying 0

(define (factorial n) ; #!
  (define product 1)
  (for ([i (in-naturals 1)]
        #:final (= i n))
        (set! product (* product i)))
    product)

; This version does not mutate a value
; it's a recursive version ...
(define (factorial-re n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))



; A simplified version of map and filter
; --------------------------------------
; first: https://bit.ly/2ZuLwih
; rest: https://bit.ly/32gTpGb

(define (my-map proc xs)
  (if (null? xs)
      null
      (cons (proc (first xs)) (my-map proc (rest xs)))))

(my-map abs (range -3 3)) ; '(3 2 1 0 1 2)


; #!: don't get how this works
(define (my-filter pred xs)
  (if (null? xs)
      null
      (if (pred (first xs))
          (cons (first xs) (my-filter pred (rest xs)))
          (my-filter pred (rest xs)))))

(my-filter even? (range 10)) ; '(0 2 4 6 8)




; Using let
; ---------
; convert natural number to string
; using a radix
; #!: https://en.wikipedia.org/wiki/Radix
; #!: https://stackoverflow.com/a/27589146

(define (n->s num [radix 10])
  (define digits
    (list->vector (string->list "0123456789abcdef")))  ; #!
  (let loop ([num num][acc empty])
    (if (zero? num)
        (if (empty? acc) "0" (list->string acc))
        (let* ([r (modulo num radix)]
               [q (/ (- num r) radix)])
          (loop q (cons (vector-ref digits r) acc))))))




;; Tail recursion
;; ==============
;; Special case: return value of recursion branch
;;               is no more than the value of the next
;;               recursive call (passing it forward)
;; i.e: you don't have to perform any operations on
;;      the value for the next iteration (passing through)
;;      of the function call. It's just a plain value.


; using an accumulator
(define (tail-factorial n [acc 1])
  (if (= n 1)
      acc
      (tail-factorial (- n 1) (* n acc)))) ; tail recursive




;; Recursion vs tail-recursion
;; ===========================
;; #1: is not tail recursion, it uses addition
;;     with each being added to the stack
;; #2: is a tail-call optimization
;;     it doesn't depend on current arguments
;;     just the result of next call to function

(define (sum n)
  (if (zero? n)
      0
      (+ n (sum (- n 1))))) ; #1

(sum 5)
; (+ 5 (sum 4))
; (+ 5 (+ 4 (sum 3)))
; (+ 5 (+ 4 (+ 3 (sum 2))))
; (+ 5 (+ 4 (+ 3 (+ 2 (sum 1)))))
; (+ 5 (+ 4 (+ 3 (+ 2 1))))
; (+ 5 (+ 4 (+ 3 3)))
; (+ 5 (+ 4 6))
; (+ 5 10)
; 15


(define (tail-sum n [acc 0])
  (if (zero? n)
      acc
      (tail-sum (- n 1) (+ n acc))))

(tail-sum 5)
; (tail-sum 4 5)
; (tail-sum 3 9)
; (tail-sum 2 12)
; (tail-sum 1 14)
; 15