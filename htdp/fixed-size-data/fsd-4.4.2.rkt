;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.4 Intervals (v2)
;; ==================
;; When your data is potentially infinite (i.e, numbers)
;; 
;;
;; #1: BUG / TODO
;;     - `stop-when` function runs BEFORE the "landed" status can run
;;     - You can `render` one final image after `stop-when`
;;     - But this causes the UFO position to fail (slightly)
;; #2: NESTED COND:
;;     - AVOID REPETITION WHEREVER POSSIBLE!
;;     - Sometimes it's cleaner to nest and avoid repetition
;;     - You can replace multiple place-image with just one
;;     - e.g: https://bit.ly/2ZReYfS

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
     [to-draw render/status]
     [stop-when landed? render/status]))  ; #1
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
;(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

; Number -> Boolean
; Stops the animation when the UFO lands
(check-expect (landed? 11) #false)
(check-expect (landed? 90) #true)
(define (landed? y)
  (if (>= y UFO-TO-TOP) #true
      #false))

; Number -> String
; Outputs the status of the UFO
(define (render/status y)
  (place-image
    (cond
      [(<= 0 y CLOSE)
      (text "descending" 20 "green")]
      [(and (< CLOSE y) (< y UFO-TO-TOP))
      (text "closing in" 20 "orange")]
      [(landed? y)
      (text "landed" 20 "red")])
    (/ WIDTH 4) UFO-TO-TOP
    (render y)))


;; You could also "chain" comparison operators
;; -------------------------------------------
; (define (test y)
;   (cond
;     [(<= 0 y CLOSE) "up"] ; 0->33.3
;     [(<= CLOSE y HEIGHT) "middle"] ; 33.4->100
;     [(>= y HEIGHT) "bottom"]))  ; 101