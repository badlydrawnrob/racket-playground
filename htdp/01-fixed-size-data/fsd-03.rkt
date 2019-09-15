;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1.7  Predicates
; ----------------
; #1: Errors are caught and described
;     - If `42` was a variable or function, errors are useful!
; #2: Predicates are a way to check the class of data
;     - It looks like: `(class? x)`
;     - Returns boolean values
; #3: Using `cond` statement (similar to if, else if)
;     -  https://docs.racket-lang.org/reference/if.html

; (* (+ (string-length 42) 1) pi)  ; #1

(require 2htdp/image)


(define in "string")
(if (string? in) (string-length in) #false)  ; #2

(define some-string "some string")
(define some-image (square 15 "solid" "yellow"))
(define some-number 20)
(define some-bool #true)

; Using cond: https://docs.racket-lang.org/reference/if.html
(define (some-value value)
        (cond
          [(string? value) (string-length value)]
          [(image? value) (* (image-width value) (image-height value))]
          [(and (number? value) (positive? value) (> value 0)) (- value 1)]
          [(equal? value #true) 10]
          [(equal? value #false) 20]
          [else (error "does not compute!")]))

