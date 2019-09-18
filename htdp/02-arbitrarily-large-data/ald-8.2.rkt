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

; Any Any -> consPair
(define (our-cons a-value a-list)
  (make-pair a-value a-list))

(our-cons 1 '())
(our-cons 1 (our-cons 2 '()))

; A ConsOrEmpty is one of:
; - '()
; - (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of ALL lists