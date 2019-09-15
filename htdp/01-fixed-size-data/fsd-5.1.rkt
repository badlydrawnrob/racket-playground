;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.1 From Positions to posn Structures
;; =====================================

(require 2htdp/universe)
(require 2htdp/image)

; Example: plot a position x,y
(make-posn 3 4)
(define one-posn (make-posn 8 6))