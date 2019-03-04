;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-data-08) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 2.3 Composing functions
;;
;; 1. What is the problem question?
;; 2. Chunk it into component parts (questions/output)
;; 3. Create one function per task
;; 4. Simplify! KISS, ACID, DRY, IO (no mutation)
;;
;; "For every constant mentioned in a problem statement,
;;  introduce one constant definition."

;; Ex.27: REDUCE, Reduce, reduce!
;; - see `fixed-size-data-07`

;; Set constants
;; — Name of a constant is a "global variable"
;; - Constant definition (left-hand side)
;; - Literal constant or expression (right-hand side)
;; - GLOBAL-VARIABLES (should be) uppercase
(define std-ticket-price 5.0)  ;; At this cost ...
(define std-attendance 120)    ;; This many people attend
(define var-price-change 0.1)  ;; For each 10-cent change ...
(define var-attendance 15)     ;; +/- 15 people difference
(define PRICE-SENSITIVITY
  (/ var-attendance var-price-change))
(define cost-per-head 0.04)
(define cost-set 180)

;; #1
(define (attendees ticket-price)
  (- std-attendance
     (* (- ticket-price std-ticket-price)
        PRICE-SENSITIVITY)))

;; #2
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

;; #3
(define (cost ticket-price)
  (+ cost-set (* cost-per-head (attendees ticket-price))))

;; #4
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
 

;; Ex.28
;; Find potential profit:
(list
 (profit 1)  ;; $1
 (profit 2)  ;; $2
 (profit 3)  ;; $3
 (profit 4)  ;; $4
 (profit 5)) ;; $5

;; Ex.29
;; Increase variable cost
;; Reduce fixed cost
;; Test prices (results in lower profits?)

(define revised-cost-per-head 1.50)
(define (revised-cost ticket-price)
  (* revised-cost-per-head (attendees ticket-price)))

(define (revised-profit ticket-price)
  (- (revenue ticket-price)
     (revised-cost ticket-price)))

(list
 (revised-profit 3)
 (revised-profit 4)
 (revised-profit 5))

;; Ex. 30
;; Add a constant for the price sensitivity
;; Add to previous functions
;;
;; See: PRICE-SENSITIVITY