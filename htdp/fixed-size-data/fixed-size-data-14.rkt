;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 3.6 Designing World Programs
;; ============================
;; @ https://bit.ly/2CKBPzI
;;
;; #1: Single point of concern
;;     - Good practice to use
;;     - Scaling this, scales everything else
;;     - e.g: `WHEEL-RADIUS` will scale the car size

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

; 1a. Physical constants
;     - General attributes of object

(define WIDTH-OF-WORLD 200)

(define WHEEL-RADIUS 5)  ; #1
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define ROOF-WIDTH (* WHEEL-RADIUS 5))
(define ROOF-HEIGHT (* WHEEL-RADIUS 2))
(define BODY-WIDTH (* WHEEL-RADIUS 10))
(define BODY-HEIGHT (* WHEEL-RADIUS 3))

; 1b. Graphical constants
;     — Images of objects in the world
;     — The visual representation
;     - Includes and renders "physical constants"

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle WHEEL-DISTANCE (/ WHEEL-RADIUS 2) "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define ROOF
  (rectangle ROOF-WIDTH ROOF-HEIGHT "solid" "red"))
(define BODY
  (rectangle BODY-WIDTH BODY-HEIGHT "solid" "red"))
(define CAR
  (overlay/offset
    BOTH-WHEELS
    0 (* (* WHEEL-RADIUS 3) -1)
    (above
     ROOF
     BODY)))



;; 2. Develop a data representation for all states of the world
;;    — What does the world look like? How is it represented with data?

; A WorldState is a Number.
; interpretation:
;    1. Number of pixels between left border of scene and the car
;    2. Or, number of clock ticks passed
; render:
;    function that changes state
; events:
;    1. clock-tick-handler
;    2. keystroke-handler
;    3. mouse-event-handler
; end?
;    When should the program stop?


;; 3. Design the functions required
;;    - Valid big-bang expressions that fulfil the purpose

(define (render-car x y car)
  (overlay/offset x y car SPACE)) 