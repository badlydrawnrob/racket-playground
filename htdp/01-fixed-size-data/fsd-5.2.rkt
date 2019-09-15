;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.2 Computing with posn
;; =======================

(require 2htdp/universe)
(require 2htdp/image)

; Example: plot a position x,y
; - similar to a cartesian point
;   @link: https://bit.ly/2Frnoj2
(define p (make-posn 31 26))
(posn-x p)  ; outputs x
(posn-y p)  ; outputs y

; (posn-x (make-posn x0 y0)) == x0
; (posn-x (make-posn x0 y0)) == y0
(posn-x (make-posn 31 26))