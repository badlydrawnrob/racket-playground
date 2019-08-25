#lang racket

; up to 1:06
;
; Feel the cool: https://youtu.be/tA1clbGDczI
; Maybe read: https://web.mit.edu/alexmv/6.037/sicp.pdf
;
; ⊡ mini-frame:
;
; 1. Skip over the stuff you know
; 2. Add interesting or "struggling with" ideas
; 3. Drill them
; 4. Learn backwards and forwards (interleave)
;
; #!: Careful changing built-in naming conventions
; #!: Careful with duck-typing (try to use TYPED)
; #!: Beware of set! and mutation: https://stackoverflow.com/a/20802742
; #!: Reading other people's (and your own code)
;     - Metaprogramming and macros can give WTF? moments
;
; #1: Use the correct test: https://bit.ly/2Pd2xKh

(require rackunit)


;; Some more basics
;; ================


; Quoting
; -------
; you don't see this in other languages
; - it can be passed around as data
; - then (eval ...)-uated as code
;
; The "code as data" you generate is in memory ...

(define a-quote '(* 3 6))
(define foo '(foo (bar "a" 3)))


; Write in plain english for functions
; ------------------------------------
; equal?
; boom!
; a*b
; co-ordinates
; <10
; +


; Duck typing
; -----------
(sort (list 3 5 2 6) <)               ; #!
(sort (list "abc" "a" "ab") string<?) ; #!


; Lambda functions
; ----------------
; no name, or "in place" functions

(map (lambda (x) (+ x 1))
     (list 1 2 3))




; Writing a clojure
; =================
; setting an internal variable
; using set! as a type of counter
; - it's output as a procedure
; - stores state (see below)

(define (counter)
        (define c 0)
        (lambda ()
          (set! c (+ c 1)) ; #!
          c))

; (a) and (b) clojures are independant
; ------------------------------------
(define a (counter)) ; should increment when run as (a)
(define b (counter)) ; a brand new counter (b)




;; Metaprogramming
;; ===============
;; Used carefully, can cut down workload
;; i.e: setting up a base multiplication function

(define (times-n n) (lambda (x) (* n x)))    ; our base * function
(define times3 (times-n 3))                  ; 3 as our base number
(define (trpl lst) (map times3 lst))         ; Pipe each list -> lambda (x)

(check-equal? (trpl (list 1 2 3)) '(3 6 9))  ; #1




;; Other weird shit
;; ================
;; - Macros
;; - Streams
;; - The Metacircular Evaluator