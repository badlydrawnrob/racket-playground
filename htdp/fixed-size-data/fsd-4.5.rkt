;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.5 Itemizations
;; ================
;;
;; A kind of fusion of enumeration and intervals
;; for instance, it could be
;; - A boolean type (only #t or #f)
;; - A number (infinite possibilities)

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Examples
;; --------
;; string->number example
;; @link https://bit.ly/2VTcoHi
;; — returns #f if not a number
;; - returns [number] if [number], i.e: "1"

; NorF -> Number
; adds 3 to the given number; 3 otherwise
(check-expect (add3 #false) 3)
(check-expect (add3 0.12) 3.12)
(define (add3 x)
  (cond
    [(false? x) 3]
    [else (+ x 3)]))

;; Sample problem
;; --------------
;; Design a program that launches a rocket
;; + When user presses space bar

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3) ; Sets the speed of launch
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; Distance -> Distance
; Decrease the distance by 3 pixels
; — Decreases distance from top of canvas
(check-expect (distance (- HEIGHT CENTER)) (- HEIGHT CENTER))
(check-expect (distance 30) 27)
(define (distance y)
  (cond
    [(= y (- HEIGHT CENTER)) (- HEIGHT CENTER)]
    [else y]))

; WorldState -> WorldState
; Render the rocket
(define (rocket y)
  (place-image
   ROCKET (/ WIDTH 2) y BACKG))

; Image -> Image
; Resting rocket

; Image -> Image
; Launching rocket


; ... -> ...
; - "resting"
; - NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight
(define (rocket/launch y a-key)
  (cond
    [(key=? a-key " ") (- y YDELTA)]
    [else y]))

; WorldState -> WorldState
; Starts the program
; - #true or #false
(define (main y)
  (big-bang y
    [on-tick distance]
    [to-draw rocket]
    [on-key rocket/launch]))