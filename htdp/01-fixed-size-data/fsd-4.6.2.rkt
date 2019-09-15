;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.6.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.6 Designing with Itemizations
;; ===============================
;; Redefining the design recipe: https://bit.ly/2H6NIkR
;; — original design recipe: https://bit.ly/2H5QOae
;;
;; See other notes in `fsd-4.6.1`
;;
;; Caution
;; --------
;; != Numbers are tricksy! https://bit.ly/2Jw2ULx
;; != BEWARE of vague ranges (up to? up to and including?)

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

; 1. Chunk each specific sub-class and distinct clauses
;    + First, split out the price (number ranges)
;    + Each sub-class is distinct from every other class

; A Price falls into one of three intervals:
; - 0 through 1000
; - 1000 through 10000
; - 10000 and above
; interpretation: the price of an item


; 2. Write out the definitions
;    + Use signature, purpose statement, function header, etc
;    + Creating the stub first


; 3. Select at least one example per sub-class:
;    + If it's a finite range, pick examples from it's:
;      - boundaries
;      - interior
;    + Be specific!


; 4. Finally write your function with conditions:
;    + the template MIRRORS the organization of sub-classes with a cond.
;    + as many conditional statements as there are sub-classes above!
; — START WITH THE CONDITIONAL STATEMENTS AND TEMPLATE `...` results


; 5. Finally, complete the function(s)
;    — concentrate on each conditional input separately

; 6. Run the tests
;    - Do they pass?
;      - Yes: congratulations!
;      - No: Revisit code, fix bugs


; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 500) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1050) (* 0.05 1050))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 10001) (* 0.08 10001))

; Template first ...
(define (sales-tax-template p)
  (cond
    [(and (>= p 0) (< p 1000)) ...]
    [(and (<= 1000 p) (< p 10000)) ...]
    [(>= p 10000) ...]))

; Then fill in the blanks ...
(define (sales-tax p)
  (cond
    [(and (>= p 0) (< p 1000)) 0]
    [(and (<= 1000 p) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))


;; Finally, add constants so taxes can be amended later
;; ====================================================
(define TAX1 0)
(define TAX2 0.05)
(define TAX3 0.08)

(define PRICE1 0)
(define PRICE2 1000)
(define PRICE3 10000)

(check-expect (sales-tax-refined PRICE1) (* TAX1 PRICE1))
(check-expect (sales-tax-refined 500) (* TAX1 PRICE1))
(check-expect (sales-tax-refined PRICE2) (* TAX2 PRICE2))
(check-expect (sales-tax-refined 1050) (* TAX2 1050))
(check-expect (sales-tax-refined PRICE3) (* TAX3 PRICE3))
(check-expect (sales-tax-refined 10001) (* TAX3 10001))

(define (sales-tax-refined p)
  (cond
    [(and (<= PRICE1 p) (< p PRICE2)) TAX1]
    [(and (<= PRICE2 p) (< p PRICE3)) (* TAX2 p)]
    [(>= PRICE3) (* TAX3 p)]))