;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6. Itemizations and Structures
;; ==============================
;;
;; != See active vs passive voice: https://bit.ly/2Gx2HoQ
;;
;; != You could use a Posn, for a 2d game ...
;;    I'm just making a 1d game here.
;;
;; != You have to adjust Posn depending on (image ...) size

(require 2htdp/image)
(require 2htdp/universe)



;; Sample problem
;; ==============
;; Design a space invader game


; Physical constants
; -------------------

(define HEIGHT 100)
(define WIDTH 300)
(define SPEED 3)

(define UPOS 10)
(define TPOS (- HEIGHT 10))


; Graphical constants
; -------------------

(define BACKGROUND
  (empty-scene WIDTH HEIGHT))

(define TANK
  (rectangle (/ WIDTH 10) (/ HEIGHT 10) "solid" "blue"))

(define UFO
  (circle (/ WIDTH 30) "solid" "yellow"))

(define MISSILE
  (triangle (/ WIDTH 30) "solid" "green"))


; Types
; -----

; A YPOS is a range (from top of BACKGROUND)
; - range[0, HEIGHT]
(define YTOP 0)
(define YMIDDLE (/ HEIGHT 2))
(define YBOTTOM (- HEIGHT (/ (image-height UFO) 2)))

; A XPOS is a range (from left to right)
; - range[0, WIDTH]
(define XLEFT (+ 0 (/ (image-width TANK) 2)))
(define XMIDDLE (/ WIDTH 2))
(define XRIGHT (+ WIDTH (/ (image-width TANK) 2)))




;; Our world
;; =========

;(define (main ...)
;  (big-bang ...
;    [on-tick tock]
;    [to-draw render]
;    [on-key commands]))



;; Our structure
;; =============

(define-struct game [ufo tank missile])
; A game is a structure
;   (make-game YPOS XPOS Posn)
; A ufo is a YPOS (moving down)
; A tank is an XPOS (moving left and right)
; A missile is a POSN (moving up)

(define SCENE1 (make-game UPOS XLEFT XLEFT))
(define SCENE2 (make-game YMIDDLE XMIDDLE XMIDDLE))
(define SCENE3 (make-game YBOTTOM XRIGHT XRIGHT))



;; Our functions
;; =============

; Game -> Image
; render the game
; - for now, hide missile behind tank
(define (render game)
  (place-image
   UFO UPOS (game-ufo game)
   (place-image
    TANK (game-tank game) TPOS
    (place-image
      MISSILE (* (game-missile game) 1) TPOS
      BACKGROUND))))



;; Utility functions
;; -----------------




; Wish list
; ---------

; Player controls the tank

; moves at constant SPEED
; can change direction on "left" or "right"

; Player defends our planet
; planet is bottom of canvas

; UFO is attacking
; see intervals (number line)
; descends from top of canvas to bottom

; Player has to fire a single missile (a triangle)
; by hitting space bar
; MISSILE APPEARS from tank (plot position)
; - straight verticle line

; If missile hits ufo player wins
; - if ref points are "close enough"
; otherwise ufo lands and player loses

