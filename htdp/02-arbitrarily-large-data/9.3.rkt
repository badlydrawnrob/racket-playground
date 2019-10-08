;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |9.3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.3 Natural Numbers
;;;; ===================
;;;;
;;;; 1. Sketch out the problem first,
;;;; 2. Write problem as lists->results table, or empty->full method
;;;; 3. Use design recipe
;;;; 4. Double check your base cases!
;;;; 5. Do you need to split out functions?
;;;; 6. How will you deal with empty lists?
;;;;


;;; Demo
;;; ====

; Create cons lists
; give me  x of y
(make-list 2 "hello") ; (cons "hello" (cons "hello" '()))
(make-list 3 #true)   ; (cons #t (cons #t (cons #t '())))
(make-list 0 17)      ; '()