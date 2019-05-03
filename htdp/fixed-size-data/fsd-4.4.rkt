;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.4 Intervals
;; =============
;;
;; #1: BUG / TODO
;;     - `stop-when` function runs BEFORE the "landed" status can run
;;     - You can `render` one final image after `stop-when`
;;     - But this causes the UFO position to fail (slightly)

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green")
                     (line 30 0 "black")))
(define UFO-TO-TOP
  (- HEIGHT (/ (image-height UFO) 2)))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]
     [stop-when landed? render]))  ; #1
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
;(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y
               (place-image (text (status y) 20 "purple")
                            (/ WIDTH 2) (- HEIGHT 20)
                            MTSCN)))

; Number -> Boolean
; Stops the animation when the UFO lands
(check-expect (landed? 11) #false)
(check-expect (landed? 90) #true)
(define (landed? y)
  (if (>= y UFO-TO-TOP) #true
      #false))

; Number -> String
; Outputs the status of the UFO
(check-expect (status 10) "descending")
(check-expect (status (+ CLOSE 1)) "closing in")
(check-expect (status UFO-TO-TOP) "landed")
(define (status y)
  (cond
    [(landed? y) "landed"]
    [(and (<= y UFO-TO-TOP) (>= y CLOSE)) "closing in"]
    [else "descending"]))