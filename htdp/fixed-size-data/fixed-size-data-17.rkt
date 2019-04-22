;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 3.7 Virtual Pet Worlds
;; ----------------------

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Exercise 47
;; Design a happiness gauge

(define CAT (bitmap "io/cat1.png"))
(define WIDTH (image-width CAT))
(define HEIGHT (image-height CAT))
(define BACKGROUND-WIDTH (* WIDTH 5))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH HEIGHT))

; Number -> Image
; Sets the happiness gauge width, renders image
; - Red bar disappears at 0
; - Red bar goes across screen at 100
(define (health width)
  (overlay/align "left" "middle"
   (rectangle BACKGROUND-WIDTH 20 "outline" "black")
   (rectangle (happiness-level width) 20 "solid" "red")))


; Number -> Number
; Checks and restrains happiness to bounding box
(define (happiness-level width)
  (cond
    [(>= width 100) BACKGROUND-WIDTH]
    [(<= width 0) 0]
    [else width]))

(check-expect (happiness-level -1) 0)
(check-expect (happiness-level 0) 0)
(check-expect (happiness-level 1) 1)
(check-expect (happiness-level 100) BACKGROUND-WIDTH)


; WorldState -> WorldState
; Reduces the number by 0.1 for every clock tick
; - Never falls below zero
(define (tock ws)
  (if (= ws 0) 0
      (- ws 0.1)))

(check-expect (tock 0) 0)
(check-expect (tock 1) 0.9)


; WorldState -> WorldState
; Increase happiness when arrow is pressed
; - 1/3 for up arrow
; - 1/5 for down arrow
(define (increase-happiness ws key)
  (cond
    [(key=? key "up") (+ ws (* ws 0.25))]
    [(key=? key "down") (+ ws (* ws 0.33))]
    [else ws]))

(check-expect (increase-happiness 1 "up") 1.25)
(check-expect (increase-happiness 1 "down") 1.33)


; WorldState -> Image
; Render the image
(define (render ws)
  (overlay/align "left" "bottom"
   (health ws)
   BACKGROUND))
   


; WorldState -> WorldState
; Set the initial state
(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tock]
    [on-key increase-happiness]))