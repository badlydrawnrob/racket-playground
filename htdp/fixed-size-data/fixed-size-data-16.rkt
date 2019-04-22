;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 3.7 Virtual Pet Worlds
;; ----------------------
;; Make the cat happy!
;;
;; #! Only covers one type of image

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Exercise 45, 46
;; — Continuously move the cat from left to right
;; — Context dependant image

(define CAT (bitmap "io/cat1.png"))
(define CAT2 (bitmap "io/cat2.png"))
(define WIDTH (image-width CAT))      ; #!
(define HEIGHT (image-height CAT))    ; #!
(define Y-HEIGHT (/ HEIGHT 2))
(define BACKGROUND-WIDTH (* WIDTH 5))

(define BACKGROUND
  (rectangle BACKGROUND-WIDTH HEIGHT "solid" "white"))
(define (render-background type position)
  (place-image
      type
      position Y-HEIGHT
      BACKGROUND))


; WorldState -> Image
; render the cat on the background
(define (render-cat ws)
  (if (odd? ws)
      (render-background CAT2 ws)
      (render-background CAT ws)))

(check-expect (render-cat 0) (place-image CAT 0 Y-HEIGHT BACKGROUND))
(check-expect (render-cat 4) (place-image CAT 4 Y-HEIGHT BACKGROUND))
(check-expect (render-cat 7) (place-image CAT2 7 Y-HEIGHT BACKGROUND))


; WorldState -> WorldState
; move the cat by 3px for each clock tick
(define (move-cat ws)
  (cond
    [(< ws BACKGROUND-WIDTH) (+ ws 3)]
    [else 0]))

(check-expect (move-cat 0) 3)
(check-expect (move-cat BACKGROUND-WIDTH) 0)


; WorldState -> WorldState
; launches the programme from some initial state
; - consumes a number, returns a number
(define (cat-prog ws)
  (big-bang ws
    [on-tick move-cat]
    [to-draw render-cat]))