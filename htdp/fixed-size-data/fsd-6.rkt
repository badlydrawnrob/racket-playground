;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6. Itemizations and Structures
;; ==============================
;;
;; != See active vs passive voice: https://bit.ly/2Gx2HoQ

(require 2htdp/image)
(require 2htdp/universe)

(define-struct world1 [ufo tank])
; A World1 is a struct
;   (make-world1 Number Number)
; ufo is the y-coordinate (only moves down)
; tank is the x-coordinate (only moves horizontal)

(define-struct world2 [ufo tank missile])
; A World2 is a struct
;   (make-world2 Number Number Number)
; ufo is the y-coordinate
; tank is the x-coordinate
; missile is the y-coordinate (only moves up)