;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.6.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.6 Programming with Structures
;; ===============================
;;
;;   (define-struct posn [x y])
;;   ; A Posn is a structure:
;;   ;   (make-posn Number Number)
;;   ; interpretation a point x pixels from left, y from top
;;
;;
;; != When to use a setter or updater?
;;    - See 5.6.1
;;
;; != ORDER MATTERS!
;;    - definitions should be in the correct order.

(require 2htdp/universe)
(require 2htdp/image)



; Sample problem
; --------------
; Keep track of object moving across canvas. Speed is changeable.
; Develop `ufo-move-1` computes the location of a given UFO after one clock tick
;
;
; Our DOMAIN KNOWLEDGE is used:
; ------------------------------------
; 1mph == 1m (after 1 hour of driving)
; ------------------------------------
; So, [8mph north, 3mph south] ...
; ... would arrive at [8m north, 3m south] of startion Posn
;
;
; STRUCTURE -> STRUCTURE
; ----------------------
; A function that consumes a structure generally outputs one


(define-struct vel [deltax deltay])
; A Vel is a structure:
;   (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical direction


(define-struct ufo [loc vel])
; A UFO is a structure
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v




; START WITH SOME EXAMPLES
; ------------------------

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))



; Use your FUNCTIONAL RECIPE
; ---------------------------
; 1. signature
; 2. purpose
; 3. examples
; 4. functional header

; UFO -> UFO
; determines where u moves in one clock tick;
; leaves the velocity as is

(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))

; (define (ufo-move-1 u)
;   (... (ufo-loc u) ... (ufo-vel u) ...))


