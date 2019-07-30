;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6. Itemizations and Structures
;; ==============================
;; Remember, a data definition represents the state of the world;
;; it also describes all possible pieces of data, driven by events.
;; The way we're describing our game is:
;;
;; - TAKING AIM or FIRED (state, keyevent)
;; - Component parts (ufo, tank, missile)
;;   - we could've just used ONE game structure
;;     (with missile #false or Posn)
;;
;;
;; != See active vs passive voice: https://bit.ly/2Gx2HoQ
;;
;; != You have to adjust Posn depending on (image ...) size
;;
;; #1: An itemization can also be a structure!
;;
;; #2: Could you avoid nested functions here somehow?

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
(define TSPEED 3)


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


; Helpers
; -------

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




;; Data definitions: types and structures
;; ======================================

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)
; > moves down only


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick
; > moves left-to-right

; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place
; > moves up when fired


;; A SIGS (space invader game) is one of:
;; - (make-aim UFO Tank)
;; - (make-fired UFO Tank Missile)

(define-struct aim [ufo tank])          ; #1
; A game is a structure
;   (make-game YPOS XPOS Posn)
; See Types above

(define-struct fired [ufo tank missile])  ; #1
; A game is a structure
;   (make-game YPOS XPOS Posn)
; See Types above

(define SCENE1 (make-aim (make-posn UPOS YTOP)
                         (make-tank XLEFT TSPEED)))
(define SCENE2 (make-fired (make-posn UPOS YMIDDLE)
                           (make-tank XMIDDLE TSPEED)
                           (make-posn XMIDDLE YMIDDLE)))
(define SCENE3 (make-fired (make-posn UPOS YBOTTOM)
                           (make-tank XMIDDLE TSPEED)
                           (make-posn XMIDDLE YTOP)))




;; Our functions
;; =============

; Game -> Image
; Depending on state, render the game
(define (render sigs)
  (cond
    [... (render-aim ...)]
    [... (render-fired ...)]))

; Game -> Image
; render the SIGS aim state
(define (render-aim aim)
  (place-image
   UFO (posn-x (aim-ufo aim)) (posn-y (aim-ufo aim))  ; #2
   (place-image
    TANK (tank-loc (aim-tank aim)) TPOS
    BACKGROUND)))

; Game -> Image
; render the SIGS fired state
(define (render-fired fired)
  (place-image
   UFO (posn-x (fired-ufo fired)) (posn-y (fired-ufo fired))  ; #2
   (place-image
    TANK (tank-loc (fired-tank fired)) TPOS
    (place-image
     MISSILE (posn-x (fired-missile fired)) (posn-y (fired-missile fired))
     BACKGROUND))))




;; Utility functions
;; -----------------





;; Our world
;; =========

;(define (main ...)
;  (big-bang ...
;    [on-tick tock]
;    [to-draw render]
;    [on-key commands]))






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

