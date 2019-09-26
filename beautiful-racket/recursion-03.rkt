;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname recursion-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 3. Example recursion
;;;; ====================
;;;; Breaking a recursive function down
;;;;
;;;; It can be helpful to think of the problem,
;;;; either as a table (see #9) or as a "backwards list"
;;;; i.e, how you'd loop through a list in Python
;;;;
;;;; - from smallest to largest
;;;; - from '() empty -> (cons ...) full
;;;;
;;;; What should each list result give us?
;;;; Write it down. Use the design recipe.
;;;; Now you can convince yourself it'll work!
;;;;
;;;; #! It can get more complicated, see the design recipe
;;;;    for a natural recursion


;; First, focus on the data definition and the function header,
;; signature, purpose statement.
;;
;; - focus on WHAT the function computes first
;; - ignore how it works for now

; A List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)      ; self-referential

; List-of-numbers -> Number
; Takes a list of numbers and returns the sum
(define (add-together-temp1 alon)
  ...)


;; Now, imagine each part of the list and WHAT it computes,
;; you can think of it backwards, starting with an empty list

'()                              ; 0
(cons 1 '())                     ; 1
(cons 2 (cons 1 '()))            ; 3
(cons 3 (cons 2 (cons 1 '())))   ; 6
; and so on ...


;; Consider how many conditional statements you'll need
;; How many mixed data are there in A List-of-numbers?
;; Fill out the function with the cons selectors you'll need
;; #!

; (define (add-together-temp2 alon)
;  (cond
;    [(empty? alon) ...]
;    [else ... (first alon) ...
;          ... (rest alon) ...]))


;; Look at the examples above, make them into tests

(check-expect (add-together '()) 0)
(check-expect (add-together (cons 1 '())) 1)
(check-expect (add-together (cons 2 (cons 1 '()))) 3)
(check-expect (add-together (cons 3 (cons 2 (cons 1 '())))) 6)


;; Decide what operator to use, and write the function
;; it should have a base case to avoid infinite loops
;; and one instance of self-reference, making sure to put it
;; in the right place! (using the right selector)

(define (add-together alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon)
             (add-together (rest alon)))]))