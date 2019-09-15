;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-intermezzo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Intermezzo 1: Beginning Student Language
;;;; ========================================
;;;;
;;;; (function argument ... argument)
;;;;
;;;; (define (function-name param ... param) — or attributes?
;;;;   function-body)
;;;;
;;;; (cond
;;;;   cond-clause
;;;;   ...)
;;;;
;;;; cond clause
;;;; [condition answer]


;;; Exercises

;; 116
; 1. variable
; 2. Keyword is to left of the expression
; 3. ""

;; 117
; 1. Keyword is in wrong position
; 2. No brackets for keyword
; 3. Variable is not allowed in brackets without keyword in front

;; 118
; 1. Keyword at start, followed by name and attribute in brackets, then expression (body)
; 2. Same, with a different body (function attribute is not used)
; 3. Two function attributes and a value as the body

;; 119
; 1. String not allowed in function head
; 2. Variable not allowed without function keyword

;; 120
; 1. bullshit
; 2. expression works, bullshit value (wrong value in expression)
; 3. expression works

;; 121

; 1.

(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))

; ==
; (+ (* 1.5 2/3)
;    (- 20 2))
; ==
; (+ 1 18)
; ==
; 19

; 2.

(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/ 1 0) 9)])

; ==
; (cond
;   [#true #false]
;   [(> 0 1) (string=? "a" "a")]
;   [else (= (/ 1 0) 9)])
; == ; by rule cond true
; #false

; 3.

(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])

; ==
; (cond
;   [#false #false]
;   [(> 2 1) (string=? "a" "a")]
;   [else (= (/ 1 2) 9)])
; == ; by rule cond false
; (cond
;   ; remove line
;   [#true (string=? "a" "a")]
;   [else (= (/ 1 2) 9)])
; == ; by rule cond true
; (string=? "a" "a")
; ==
; #true
