;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Designing with Self-Referential Data Definitions
;;;; ================================================
;;;; See the design recipe, it's a little more involved
;;;; but to me it's worded in a confusing way ...
;;;; @link: https://bit.ly/2m6meVE
;;;;
;;;; It's a little similar to mixed data definition, but all
;;;; pieces of the data definition must have a place in the template
;;;; (including the self-referential part)
;;;;
;;;; '()
;;;; empty?
;;;; cons
;;;; first
;;;; rest
;;;; cons?
;;;;
;;;;
;;;; #1: This is one of your "base cases" to stop an infinite loop
;;;;
;;;;     - The book doesn't use (cons? ...) as the second selector
;;;;
;;;; #2: The self referential function maps to the same place as the
;;;;     data definition (the right part of the second cond clause)
;;;;     This is called a natural recursion.
;;;;
;;;;     - The data definition references itself ONCE
;;;;     - so the recursive function should be referenced ONCE
;;;;
;;;; #3: You could probably use add1 as a function here



;;; 1. Start with the data definition
;;; ---------------------------------

; A list of strings is one of
; - '()
; - (cons String List-of-strings)


;;; 2. Create a function example
;;; ----------------------------
;;; Focus on what data goes in, and out
;;; don't worry about how it works yet

; List-of-strings -> Number
; counts how many strings alos contains
(define (how-many-temp-01 alos)
  0)


;;; 3. Consider what you should see
;;; -------------------------------
;;; Using functional examples

; given                     ; wanted
; '()                       ; 0
; (cons "a" '())            ; 1
; (cons "b" (cons "a" '())) ; 2
; ...                       ; ...


;;; 4. You'll need cond expressions
;;; -------------------------------
;;; As many clauses in the data definition
;;; you'll need cond expressions
;;; - sub classes of data?
;;; - structured values and selectors?
;;; - self-references?
;;; - anything else? string?

(define (how-many-temp-02 alos)
  (cond
    [(empty? alos) ...]    ; #1
    [else                  ; #1
     (... (first alos) ...
      ... (how-many-cond (rest alos)) ...)])) ; #2


;;; 5. Start building the function body
;;; -----------------------------------
;;; Using step 3 as a guide

(define LIST0 '())
(define LIST1 (cons "a" '()))
(define LIST2 (cons "a" (cons "b" '())))
(define LIST3 (cons "a" (cons "b" (cons "c" '()))))

; A list of strings -> Number
; For every string in a list, add one
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else
     (+ (how-many (rest alos)) 1)])) ; #3

(check-expect (how-many LIST0) 0)
(check-expect (how-many LIST1) 1)
(check-expect (how-many LIST2) 2)
(check-expect (how-many LIST3) 3)