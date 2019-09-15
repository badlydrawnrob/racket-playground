;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6. Itemizations and Structures
;; ==============================
;; See 6.1.1.rkt for full notes (`...` removed for ease-of-scanning)
;;
;; #!: This is wrong and will return #true on horizontal axis
;;     which isn't what we want. See: https://www.mathopenref.com/coordpointdistvh.html
;;     YOU NEED THIS FOR THE (landed? ...) function to work!!!
;;
;; #!: Be careful of too many constants
;;
;; #1: An itemization can also be a structure!
;;     ...
;;
;; #2: Avoid nested functions!!
;;     a. Chunk functions for reuse.
;;     b. Split out the UFO, TANK, MISSILE from the SIGS struct
;;     c. An easier way to do unit tests?
;;
;; #3: A predicate explained in Python: https://youtu.be/wo36QTibfiE
;;     a. You're actually using predicates AS the condition
;;        + SIGS game states
;;        + (hit? ...) or (landed? ...)
;;     b. Number maybe negative (if not close)
;;     c. Distance to zero (top-left origin): `fsd-5.3.rkt`
;;
;;        #! HERE BE BUGS. It's right in theory but not in practice,
;;           you just need the vertical access and #4 screws this up
;;           for now, set a bounding box for UFO and keep as-is.
;;
;; #4: Random numbers are hard to test!
;;     - Use a child function
;;     - Or one function, see docs for (check-random ...) testing
;;
;;        #! IDEALLY, I was trying to set up a bounding box,
;;           then "flip" the RANDOM number to a negative
;;           + left->right until XBOUNDING
;;           + then right->left until XLEFT (repeat)
;;
;; #5: Split out the tests
;;     - Using constants is a ballache; reduce, or use better ones:
;;       + TLEFT, TRIGHT
;;
;; #6: A lot of repetition creating instances (make-ufo ...) etc


(require 2htdp/image)
(require 2htdp/universe)



;; Sample problem
;; ==============
;; Design a space invader game

;; Original wish list
;; ------------------
;; ...


; Physical constants
; -------------------

(define HEIGHT 100)
(define WIDTH 300)
(define SPEED 3)

(define UPOS 10)
(define ULAND 90)
(define USPEED 1)
(define UBOUNDING (- ULAND 1))
(define TPOS (- HEIGHT 10))
(define TSPEED 3)
(define MSPEED 3)

(define SENSITIVITY 2)
(define RANDOM 3)


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


; Helper constants
; ----------------
; must come after declared variables

; A YPOS is a range (from top of BACKGROUND)
; - range[0, HEIGHT]
(define YTOP 0)
(define YMIDDLE (/ HEIGHT 2))
(define YBOTTOM (- HEIGHT (/ (image-height UFO) 2)))

; A XPOS is a range (from left to right)
; - range[0, WIDTH]
(define XLEFT (+ 0 (/ (image-width TANK) 2)))
(define XBOUNDING UBOUNDING) ; #!
(define XMIDDLE (/ WIDTH 2))
(define XRIGHT (+ WIDTH (/ (image-width TANK) 2)))




;; Our core objects
;; ================
;; A UFO moves left->right
;; A TANK moves left->right
;; A Missile moves up

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place


;; Our space invader game
;; ======================
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


;; Helpful constants
;; -----------------

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




;; Setting up the game
;; ===================
;; See SCENE examples at #2c

; SIGS -> Image
; Render game state on top of BACKGROUND
; generates TANK, UFO, and possibly MISSILE
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


(render SCENE1)  ; #2c
(render SCENE2)  ; #2c
(render SCENE3)  ; #2c
(render SCENE4)  ; #2c




;; Game over?
;; ==========
;; Missile hit UFO (win)
;; UFO landed (lose)

; SIGS -> Boolean?
; Determines if the UFO has been hit
; - UFO landed
; - UFO hit
(define (si-game-over? s)
  (cond
    [(aim? s)
     (landed? (aim-ufo s))]
    [(fired? s)
     (or (landed? (fired-ufo s))
         (hit? (fired-ufo s) (fired-missile s)))]))  ; #3a

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
(check-expect (landed? UFO4) #true)     ; #!


; UFO MISSILE -> Number
; Calculate how close they are
(define (how-close ufo missile)
  (abs (- (distance-to-0 ufo)
          (distance-to-0 missile))))     ; #3b

(check-expect (how-close UFO1 MISSILE1) 164)
(check-expect (how-close UFO2 MISSILE2) 2)
(check-expect (how-close UFO3 MISSILE3) 100)


; Posn -> Number
; Distance to origin (top-left)
(define (distance-to-0 p)
  (inexact->exact
   (floor (sqrt (+ (sqr (posn-x p))
                   (sqr (posn-y p)))))))  ; #3c

(check-expect (distance-to-0 (make-posn 0 0)) 0)
(check-expect (distance-to-0 (make-posn 2 2)) 2)
(check-expect (distance-to-0 (make-posn 5 7)) 8)


;; Render the final scene
;; ----------------------

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
  (make-aim (random-ufo-main ufo RANDOM) (move-tank tank)))

; UFO Tank Missile -> SIGS
(define (move-fired ufo tank missile)
  (make-fired (random-ufo-main ufo RANDOM) (move-tank tank) (move-missile missile)))


; UFO Number -> UFO
(define (random-ufo-main u rand)  
  (random-ufo u (random rand)))               ;; #4

; UFO Number -> UFO
(define (random-ufo u num)       
  (make-posn (+ (posn-x u) num) (+ (posn-y u) USPEED)))  ;; #4

(check-expect (random-ufo UFO1 RANDOM) (make-posn 13 1))

;(define (random-ufo u num)       
;  (cond
;    [(left? u) (make-posn (+ (posn-x u) num) (posn-y u))]
;    [(right? u) (make-posn (- (posn-x u) num) (posn-y u))]))  ;; #4





; Tank -> Tank
; move tank, but stop moving when appropriate
; - right (3)
; - left (-3)
(define (move-tank t)
  (cond
    [(left? t) t]  ;; #5
    [(right? t) t] ;; #5
    [else (make-tank (+ (tank-loc t) (tank-vel t))
                     (tank-vel t))])) ;; #5

(check-expect (move-tank TANK1) (make-tank 18 3))
(check-expect (move-tank TANK3) (make-tank XLEFT -3))




;; Add a bounding box
;; ------------------
;; We can only go so far left->right with our
;; UFO and TANK. Set up itemization for this:

(define (left? obj)
  [cond
    [(tank? obj)
     (and (= (tank-loc obj) XLEFT)
          (= (tank-vel obj) -3))]
    [(posn? obj)
     (= (posn-x obj) XLEFT)]])

(check-expect (left? (make-tank XLEFT -3)) #true)
(check-expect (left? (make-tank XLEFT 3)) #false)
(check-expect (left? (make-posn XLEFT YTOP)) #true)
(check-expect (left? (make-posn XBOUNDING YTOP)) #false)

(define (right? obj)
  (cond
    [(tank? obj)
     (and (= (tank-loc obj) XRIGHT)
       (= (tank-vel obj) 3))]
    [(posn? obj)
     (= (posn-x obj) XBOUNDING)]))
  

(check-expect (right? (make-tank XRIGHT -3)) #false)
(check-expect (right? (make-tank XRIGHT 3)) #true)
(check-expect (right? (make-posn XLEFT YTOP)) #false)
(check-expect (right? (make-posn XBOUNDING YTOP)) #true)




; Missile -> Missile
(define (move-missile m)
  (make-posn (posn-x m)
             (- (posn-y m) MSPEED)))

(check-expect (move-missile MISSILE1) (make-posn 150 (- 90 MSPEED)))
(check-expect (move-missile MISSILE2) (make-posn 15 (- 50 MSPEED)))




;; Our Player KeyEvents
;; ====================

; KeyEvent SIGS -> SIGS
; - sigs-aim
; - sigs-fired ("spacebar")
; - move-tank-left ("left")
; - move-tank-right ("right")
(define (commands s ke)
  (cond
    [(key=? ke " ") (fire! (aim-ufo s) (aim-tank s) (tank-vel (aim-tank s)))]
    [(key=? ke "left") (flip-tank  s (* TSPEED -1))]
    [(key=? ke "right") (flip-tank s TSPEED)]
    [else s]))

(define (fire! ufo tank vel)
  (make-fired (make-posn (posn-x ufo) (posn-y ufo))
              (make-tank (tank-loc tank) vel)
              (make-posn (tank-loc tank) YBOTTOM)))

(define (flip-tank s vel)
  (cond
    [(aim? s) (flip-tank-aim (aim-ufo s) (aim-tank s) vel)]
    [(fired? s) (fire! (fired-ufo s) (fired-ufo s) vel)]))

(define (flip-tank-aim ufo tank vel)
  (make-aim (make-posn (posn-x ufo) (posn-y ufo))
            (make-tank (tank-loc tank) vel)))




;; Our world
;; =========

(define (main sigs)
  (big-bang sigs
    [on-tick si-move]
    [to-draw render]
    [on-key commands]
    [stop-when si-game-over? si-render-final]))










