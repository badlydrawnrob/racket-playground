;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Designing with Self-Referential Data Definitions
;;;; ================================================
;;;; See the design recipe, it's a little more involved
;;;; @link: https://bit.ly/2m6meVE
;;;;
;;;; It's a little similar to mixed data definition
;;;;
;;;; '()
;;;; empty?
;;;; cons
;;;; first
;;;; rest
;;;; cons?



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
(define (how-many alos)
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

(define (how-many-cond alos)
  (cond
    [(empty? alos) ...]    ; needed
    [else
     (... (first alos) ... (rest alos) ...)])) ; optional