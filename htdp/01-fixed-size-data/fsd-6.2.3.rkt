;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.2.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.2 Mixing up worlds
;; ====================
;;
;; != Could have used 3 structs for each state?
;;    - A couple of minor bits ripped from `108_pedestrian_light.rkt`
;;    - (zero? ...) is quite clever as used for 2 states
;;
;;      - TRUTHY! So the first (cond ...) takes priority
;;      - Order matters.
;;
;; != There's a few ways to do this. SKETCH IT OUT!
;;    - Two structs for the states
;;    - One struct with a string for the state
;;
;; != Keep naming conventions consistant ("stop" "go" etc)
;;
;;
;; #1: You don't need to add any struct information to image
;;     as it's static (see 6.1.3.rkt)
;;
;; #2: Switch state
;;
;; #3: The old predicate isn't needed
;;     (zero? ...) is much more graceful in this case.

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
(define BLACK "black")
(define DONT-WALK "stop")
(define WALK "go")
(define CAREFUL! "count")
(define COUNT 9) ; 0 counts as a second

; graphical
(define STOP (bitmap "io/pedestrian_traffic_light_red.png"))
(define GO (bitmap "io/pedestrian_traffic_light_green.png"))



;; Data structure
;; --------------

; State is a String:
; - DONT-WALK
; - WALK

; Countdown is a Number
; - range[0,10] (in reverse, 10 second countdown)

(define-struct crossing [state countdown])
; A Crossing is a struct
;   (make-struct State Countdown)
; State tells us if we can walk
; Countdown tells us how long we have to walk

(define CROSS1 (make-crossing DONT-WALK 0))
(define CROSS2 (make-crossing WALK 9))
(define CROSS3 (make-crossing WALK 0))
(define CROSS4 (make-crossing CAREFUL! 9))
(define CROSS5 (make-crossing CAREFUL! 0))




;; Images
;; ------

; Crossing -> Image
(define (render c)
  (cond
    [(string=? DONT-WALK (crossing-state c))
     (render-stop (render-scene RED))]
    [(string=? WALK (crossing-state c))
     (render-go (render-scene GREEN))]
    [(string=? CAREFUL! (crossing-state c))
     (render-countdown (crossing-countdown c) (render-scene BLACK))]))


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




;; The states
;; ----------


(define (tock c)
  (cond
    [(string=? DONT-WALK (crossing-state c)) c]
    [(zero? (crossing-countdown c))
     (switch-state c)]  ; #2
    [else
     (make-crossing (crossing-state c)
                    (sub1 (crossing-countdown c)))]))

(check-expect (tock CROSS1) CROSS1)
(check-expect (tock CROSS2) (make-crossing WALK 8))
(check-expect (tock CROSS3) CROSS4)
(check-expect (tock CROSS4) (make-crossing CAREFUL! 8))
(check-expect (tock CROSS5) CROSS1)


; Crossing -> Crossing
(define (switch-state c)
  (cond
    [(string=? WALK (crossing-state c))
     (make-crossing CAREFUL! COUNT)]
    [else
     (make-crossing DONT-WALK 0)]))

(check-expect (switch-state CROSS3) CROSS4)
(check-expect (switch-state CROSS5) CROSS1)



;; #3

; Number -> Boolean?
; (define (walk? n)
;   (if (and (> n 0) (<= n 9))
;       #true
;       #false))

; (check-expect (walk? 0) #false)
; (check-expect (walk? 1) #true)
; (check-expect (walk? 9) #true)
; (check-expect (walk? 10) #false)






;; KeyEvent
;; --------

(define (event c ke)
  (cond
    [(key=? " " ke) (make-crossing WALK 10)]
    [else c]))

(check-expect (event CROSS1 "c") CROSS1)
(check-expect (event CROSS1 " ") (make-crossing WALK 10))




;; Running the program
;; -------------------

(define (main c)
  (big-bang c
    [on-tick tock .7]
    [to-draw render]
    [on-key event]))




