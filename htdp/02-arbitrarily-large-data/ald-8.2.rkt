;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-8.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 8.2 What is '(), What is cons
;;;; =============================
;;;;
;;;; #: '() is just a constant
;;;;     - it represents an empty list
;;;;     - an atomic value like 1, #true, "string"
;;;;     - it has it's own predicate function
;;;;
;;;; #: cons is a structure, it takes a pair:
;;;;    one side any kind of value, the other a list-like value
;;;;
;;;;    - it has it's own selectors (like a structure)
;;;;    - cad/first
;;;;    - cdr/rest


; Any -> Boolean
; is the given value '()

(empty? '())            ; #t
(empty? 5)              ; #f
(empty? "this")         ; #f
(empty? (cons 1 '()))   ; #f
(empty? (cons "t" '())) ; #f


; Any List -> List
(cons 1 (cons 2 '()))


;;; Building a list-type struct
;;; ---------------------------
;;; We can get half-way to making a cons-like
;;; function, but it won't enforce a list on
;;; the right side ... so we need to force it

(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any)

(define OUR1 "first")
(define OUR2 "rest")
(define OUR3 (make-pair OUR2 '()))


;; The wrong way to do it:
;; -----------------------

; Any Any -> consPair
; (define (our-cons a-value a-list)
;  (make-pair a-value a-list))

; (our-cons 1 '())
; (our-cons 1 (our-cons 2 '()))


;; The right way to do it:
;; -----------------------

; A ConsOrEmpty is one of:
; - '()
; - (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of ALL lists

; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

(check-error (our-cons OUR1 #false) "cons: second argument ...")
(check-expect (our-cons OUR1 '()) (make-pair OUR1 '()))
(check-expect (our-cons OUR1 OUR3) (make-pair OUR1 OUR3))

;;; Make our own cad and cdr
;;; ------------------------

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> Any
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "...")
      (pair-right a-list)))


; With the real cons these would work, but our function
; does not

(check-expect (our-first (our-cons OUR1 '())) OUR1)  ; pull left-side
(check-expect (our-rest (our-cons OUR1 '())) '())    ; empty
(check-expect (our-rest (our-cons OUR1 OUR3)) OUR3)  ; pull right-side





;; List primitives:
; '()     - a special value, mostly to represent the empty list
; empty?  - a predicate to recognize '() and nothing else
; cons    - a checked constructor to create two-field instances
; first   - the selector to extract the last item added
; rest    - the selector to extract the extended list
; cons?   - a predicate to recognizes instances of cons
