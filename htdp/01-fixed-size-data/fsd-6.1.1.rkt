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
;; != Too many constants might make things more confusing
;;    might be better to just use individual entries on (make-tank ...) etc?
;;
;; != See active vs passive voice: https://bit.ly/2Gx2HoQ
;;
;; != You have to adjust Posn depending on (image ...) size
;;
;;
;; #1: An itemization can also be a structure!
;;     - Here, you're describing both the state of the game
;;     - As well as the structure (and it's Types)
;;
;; #2a: Avoid nested functions more than one level deep!
;;      Pass through the UFO, TANK, MISSILE .. read inside out:
;;      - Generate a background with UFO and a BACKGROUND
;;      - Pass this Image to the (tank-render ...) function
;;      - Generate your final image
;;
;;      != Chunking functions in this way allows reuse!
;;
;; #2b: Try to avoid nested functions where possible (see #2)
;;     - rather than passing the whold SIGS struct to the render
;;       functions, we only pass it's objects (UFO, TANK, MISSILE)
;;
;; #2c: Is there an easy way to do proper unit tests?
;;
;; #3a: A predicate that returns #true or #false
;;      - I wonder if you could reuse the render functions here?
;;        + if it looks like x or y image
;;
;; #3b: The number could be negative (if not close) so
;;      use (abs ...)
;;
;; #3c: Distance to zero (from origin)
;;      - See `fsd-5.3.rkt` for original task
;;
;;      != Our origin is TOP-LEFT
;;
;; #4: Random numbers are hard to test, so we split out
;;     our function into:
;;     - easy to test (main body)
;;     - don't bother to test (pass the random function to main)
;;
;;     != you could use (check-random ...) instead

(require 2htdp/image)
(require 2htdp/universe)



;; Sample problem
;; ==============
;; Design a space invader game

;; Original wish list
;; ------------------

;; Player controls the tank
;; - moves at constant SPEED
;; - can change direction on "left" or "right"

;; Player defends our planet
;; planet is bottom of canvas

;; UFO is attacking
;; - see intervals (number line)
;; - descends from top of canvas to bottom

;; Player has to fire a single missile (a triangle)
;; - triggered by space bar
;; - missile appears from tank (plot position)
;; - straight verticle line




; Physical constants
; -------------------

(define HEIGHT 100)
(define WIDTH 300)
(define SPEED 3)

(define UPOS 10)
(define ULAND 90)
(define TPOS (- HEIGHT 10))
(define TSPEED 3)
(define MSPEED 3)

(define SENSITIVITY 3)


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
;; Our main game structure (#1) is actually
;; an itemization!

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

(define-struct aim [ufo tank])            ; #1
; A game is a structure
;   (make-aim UFO Tank)
; See Types above

(define-struct fired [ufo tank missile])  ; #1
; A game is a structure
;   (make-fired UFO Tank Missile)
; See Types above

(define TANK1 (make-tank XLEFT TSPEED))
(define TANK2 (make-tank XMIDDLE TSPEED))
(define TANK3 (make-tank XLEFT (* TSPEED -1)))
(define TANK4 (make-tank XMIDDLE (* TSPEED -1)))

(define UFO1 (make-posn UPOS YTOP))
(define UFO2 (make-posn UPOS YMIDDLE))
(define UFO3 (make-posn UPOS YMIDDLE))
(define UFO4 (make-posn UPOS YBOTTOM))

(define MISSILE1 (make-posn XMIDDLE TPOS))
(define MISSILE2 (make-posn XLEFT YMIDDLE))
(define MISSILE3 (make-posn XMIDDLE YTOP))

(define SCENE1 (make-aim UFO1 TANK1))
(define SCENE2 (make-fired UFO2 TANK2 MISSILE1))
(define SCENE3 (make-fired UFO3 TANK3 MISSILE2))
(define SCENE4 (make-fired UFO4 TANK4 MISSILE3))




;; Our functions
;; =============

; SIGS -> Image
; Renders the given game state on top of BACKGROUND
; generates TANK, UFO, and possibly MISSILE
; - See examples #2c
(define (render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]  ; #2a
    [(fired? s)
     (missile-render (fired-missile s)
                     (tank-render (fired-tank s)
                                  (ufo-render (fired-ufo s)
                                              BACKGROUND)))]))


; Tank Image -> Image
; adds t to the given image im
(define (tank-render t im)
  (place-image
   TANK (tank-loc t) TPOS         ; #2b
   im))

; UFO Image -> Image
(define (ufo-render u im)
  (place-image
   UFO (posn-x u) (posn-y u)      ; #2b
   im))

; Missile Image -> Image
(define (missile-render m im)
  (place-image
   MISSILE (posn-x m) (posn-y m)  ; #2b
   im))


; Hacky test it works:
(render SCENE1)  ; #2c
(render SCENE2)  ; #2c
(render SCENE3)  ; #2c
(render SCENE4)  ; #2c




;; Game over?
;; ----------
;; If missile hits ufo player wins
;; - if ref points are "close enough"
;;   otherwise ufo lands and player loses

; SIGS -> Boolean?
; Determines if the UFO has been hit
; - UFO landed
; - UFO hit
(define (si-game-over? s)
  (cond
    [(and (fired? s)
          (landed? (fired-ufo s))) #true]  ; #3a
    [(and (fired? s)
          (hit? (fired-ufo s) (fired-missile s))) #true]
    [else #false])) 

(check-expect (si-game-over? SCENE1) #false)
(check-expect (si-game-over? SCENE2) #false)
(check-expect (si-game-over? SCENE3) #true)
(check-expect (si-game-over? SCENE4) #true)

; UFO MISSILE -> Boolean?
; Has the missile hit our target?
(define (hit? ufo missile)
  (<= (how-close ufo missile) SENSITIVITY))

(check-expect (hit? UFO1 MISSILE1) #false)
(check-expect (hit? UFO2 MISSILE2) #true)
(check-expect (hit? UFO3 MISSILE3) #false)

; UFO LANDED -> Boolean?
(define (landed? ufo)
  (= (distance-to-0 ufo) ULAND))

(check-expect (landed? UFO1) #false)
(check-expect (landed? UFO2) #false)
(check-expect (landed? UFO3) #false)
(check-expect (landed? UFO4) #true)

; UFO MISSILE -> Number
; Calculate how close they are
(define (how-close ufo missile)
  (abs (- (distance-to-0 ufo)
          (distance-to-0 missile))))     ; #3b

(check-expect (how-close UFO1 MISSILE1) 164)
(check-expect (how-close UFO2 MISSILE2) 2)
(check-expect (how-close UFO3 MISSILE3) 100)

; Posn -> Number
; Find the distance to origin
(define (distance-to-0 p)
  (inexact->exact
   (floor (sqrt (+ (sqr (posn-x p))
                   (sqr (posn-y p)))))))  ; #3c

(check-expect (distance-to-0 (make-posn 0 0)) 0)
(check-expect (distance-to-0 (make-posn 2 2)) 2)
(check-expect (distance-to-0 (make-posn 5 7)) 8)
   
; SIGS -> Image
; Did they win or lose? Tell them when the game is finished.
(define (si-render-final s)
  (cond
    [(landed? (fired-ufo s)) (win-lose "Loser :(")]
    [(hit? (fired-ufo s) (fired-missile s)) (win-lose "Winner!")]))

; Text -> Image
(define (win-lose copy)
  (place-image
   (text copy 24 "olive")
   XMIDDLE YMIDDLE
   BACKGROUND))

(si-render-final SCENE3)
(si-render-final SCENE4)




;; Move our objects
;; ================
;; for every clock tick
;;
;; 1. Tank moves left->right
;; 2. Missile moves up
;; 3. UFO jumps randomly left->right

; SIGS -> SIGS
; Moves our TANK, UFO, maybe MISSILE
(define (si-move s)
  (cond
    [(aim? s) (move-aim (aim-ufo s) (aim-tank s))]
    [(fired? s) (move-fired (fired-ufo s) (fired-tank s) (fired-missile s))]))

; UFO Tank -> SIGS
; Create a new SIGS with movement
(define (move-aim ufo tank)
  (make-aim (move-ufo ufo) (move-tank tank)))

; UFO Tank Missile -> SIGS
(define (move-fired ufo tank missile)
  (make-fired (move-ufo ufo) (move-tank tank) (move-missile missile)))

; UFO -> UFO
; move UFO randomly
(define (move-ufo u)
  (random-ufo u WIDTH))

; UFO Number -> UFO
(define (random-ufo x u)
  (make-posn (random x) (posn-y u)))

(check-expect (move-ufo UFO1) UFO1)

; Number -> Number
; Random number between [0, x)
;(define (si-move w)
;  (si-move-proper w (random 3)))

; SIGS Number -> SIGS
; (define (si-move-proper w delta)
;  w)

; Tank -> Tank
; move tank
; - right (3)
; - left (-3)
(define (move-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t))
             (tank-vel t)))

(check-expect (move-tank TANK1) (make-tank 18 3))
(check-expect (move-tank TANK3) (make-tank 12 -3))

; Missile -> Missile
(define (move-missile m)
  (make-posn (posn-x m)
             (+ (posn-y m) MSPEED)))

(check-expect (move-missile MISSILE1) (make-posn 150 (+ 90 MSPEED)))
(check-expect (move-missile MISSILE2) (make-posn 15 (+ 50 MSPEED)))





;; Our world
;; =========

;(define (main ...)
;  (big-bang ...
;    [on-tick tock]
;    [to-draw render]
;    [on-key commands]
;    [stop-when si-game-over? si-render-final]))










