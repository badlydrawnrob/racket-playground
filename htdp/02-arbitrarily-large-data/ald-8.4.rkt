;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-8.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Computing with Lists
;;;; ====================
;;;; Using the stepper to see how code is evaluated

;;; Exercise 135
;;; ------------

; A List of Names is one of:
; - '()
; - (cons Name ALON)
; interpretation a list of names

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (flatt? (first alon))
         (contains-flatt? (rest alon)))]))

; String -> Boolean
(define (flatt? s)
  (string=? s "Flatt"))

(contains-flatt? (cons "Flatt" (cons "C" '())))            ; #t
(contains-flatt? (cons "A" (cons "Flatt" (cons "C" '())))) ; #t
(contains-flatt? (cons "A" (cons "B" (cons "C" '()))))     ; #f



;;; Exercise 136
;;; ------------

(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any)

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

(our-first (our-cons "a" '())) ; == a
(our-rest (our-cons "a" '()))  ; == '()