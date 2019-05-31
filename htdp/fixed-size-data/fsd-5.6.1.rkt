;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.6 Programming with Structures
;; ===============================
;;
;;   (define-struct posn [x y])
;;   ; A Posn is a structure:
;;   ;   (make-posn Number Number)
;;   ; interpretation a point x pixels from left, y from top
;;
;;
;; #1: Use a "setter" (or updater) function
;;     - != when to use? when not to?

(require 2htdp/universe)
(require 2htdp/image)



;; An Entry is a simple (flat) structure type
;; ------------------------------------------

(define-struct entry [name phone email])
; An Entry is a structure:
;    (make-entry String String String)
; interpretation a contact's name, phone#, email


;; A Ball could have many different representations
;; ------------------------------------------------
;; You can use the same struct in different ways
;; --> Whatever you choose, STICK TO IT :)

(define-struct ball [location velocity])
; A Ball-1d is a structure:
;   (make-ball Number Number)
; interpretation 1 distance to top and velocity
; interpretation 2 distance to left and velocity

; A Ball-2d is a structure
;   (make-ball Posn Vel)
; interpretation a 2-dimensional position and velocity

(define-struct vel [deltax deltay])
; A Vel is a structure:
;   (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical direction



;; Exercise 72
;; -----------

(define-struct phone# [area switch num])
; A Phone# is a structure
;   (make-phone# Number Number Number)
; interpretation (make-phone# a0 s0 n0) means:
; - The area code (state)
; - The phone switch (neighborhood)
; - The phone number (neighborhood)



; Sample problem
; --------------
; Design an interactive game that moves a red dot around a canvas
; Allow players to use the mouse to reset the dot

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
(define RESET (make-posn
               (quotient (image-width MTS) 2)
               (quotient (image-height MTS) 2)))


; A Posn represents the state of the world
; ----------------------------------------

; Posn -> Posn
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse set-dot-position]
    [to-draw scene+dot]))


; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))


;; Sample problems
;; ---------------

; Posn -> Posn
; Allow user to reset the dot on mouse event (mouse click)
(define (reset-dot p x y me)
  (cond
    [(string=? "button-down" me) RESET]
    [else (make-posn (posn-x p) (posn-y p))]))

(check-expect (reset-dot (make-posn 10 20) 5 10 "button-down") RESET)

; Posn -> Posn
; Allow user to choose position on mouse event
(define (set-dot-position p x y me)
  (cond
    [(string=? "button-down" me) (make-posn x y)]
    [else p]))

(check-expect (set-dot-position (make-posn 21 40) 15 9 "button-down")
              (make-posn 15 9))
(check-expect (set-dot-position (make-posn 30 21) 20 18 "button-up")
              (make-posn 30 21))


; Posn -> Posn
; Move the dot x-cordinate 3 pixels on each clock tick
(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))
  ; (make-posn (+ (posn-x p) 3) (posn-y p)))

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))




;; Exercise 73
;; -----------
;; Consumes a Posn p and a Number n

(define (posn-up-x p n)
  (make-posn n (posn-y p)))  ; #1

(check-expect (posn-up-x (make-posn 10 20) 30) (make-posn 30 20))



;; Exercise 74
;; -----------
;; Done (I think)

; > (main (make-posn 0 50))
