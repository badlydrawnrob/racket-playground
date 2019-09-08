;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.2.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.2 Mixing up worlds
;; ====================
;;
;; != There's a few ways to do this. SKETCH IT OUT!
;;    - Two structs for the states
;;    - One struct with a string for the state
;;
;; #1: You don't need to add any struct information to image
;;     as it's static (see 6.1.3.rkt)

(require 2htdp/universe)
(require 2htdp/image)


;; Exercise 108
;; ------------

; Default state orange person on red background
; is it time to cross?
; switch to green
; countdown from 10->0
;   - odd numbers are orange
;   - even numbers are green
; when zero, switch to default state


; physical
(define HEIGHT 60)
(define WIDTH 70)
(define X (/ WIDTH 2))
(define Y (/ HEIGHT 2))
(define RED "red")
(define GREEN "green")
(define ORANGE "orange")
(define DONT-WALK "stop")
(define WALK "go")

; graphical
(define STOP (bitmap "io/pedestrian_traffic_light_red.png"))
(define GO (bitmap "io/pedestrian_traffic_light_green.png"))



;; Data structure
;; --------------

; State is a String:
; - DONT-WALK
; - WALK

; Countdown is a Number
; - range[10->0]

(define-struct crossing [state countdown])
; A Crossing is a struct
;   (make-struct State Countdown)
; State tells us if we can walk
; Countdown tells us how long we have to walk

(define CROSS1 (make-crossing DONT-WALK 10))
(define CROSS2 (make-crossing WALK 10))
(define CROSS3 (make-crossing WALK 0))




;; Images
;; ------

; Crossing -> Image
(define (render c)
  (cond
    [(string=? DONT-WALK (crossing-state c))
     (render-stop (render-scene RED))]
    [(string=? WALK (crossing-state c))
     (render-countdown (crossing-countdown c)
                       (render-go (render-scene GREEN)))]))


; Color -> Image
(define (render-scene color)
  (empty-scene WIDTH HEIGHT color))

; Image -> Image
(define (render-stop img)
  (place-image STOP X Y img))  ; #1

; Image -> Image
(define (render-go img)
  (place-image GO X Y img))

; Number Image -> Image
(define (render-countdown n img)
  (place-image (countdown n) X Y img))

; Number -> Image
(define (countdown n)
  (text (number->string n)
        24
        (cond
          [(odd? n) ORANGE]
          [(even? n) GREEN])))

(check-expect (countdown 1) (text "1" 24 ORANGE))
(check-expect (countdown 2) (text "2" 24 GREEN))




;; Checking state
;; --------------

; Number -> Boolean?
(define (walk? n)
  (if (and (> n 0) (<= n 10))
      #true
      #false))

(check-expect (walk? 0) #false)
(check-expect (walk? 1) #true)
(check-expect (walk? 10) #true)
(check-expect (walk? 11) #false)




