;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-size-data-04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 2.0 Functions and Programs
;
; Variable, function definition,
; function application, function composition
;
; != No functions check for type:
;    - calling functions with wrong type throws errors

(require 2htdp/image)


(define (some-string x)
  (string-ref x 2))

; Ex.11 != need more maths knowledge
; Ex.12 != think is length**3 but not sure

; Ex.13 Extract 1st string
(define (string-first s)
  (if (> (string-length s) 0) (string-ith s 0) (error "string is empty")))

; Ex.14 Extract last string
(define (string-last s)
  (if (> (string-length s) 0)
      (string-ith s (- (string-length s) 1))
      (error "string is empty")))
