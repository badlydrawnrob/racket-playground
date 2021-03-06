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
;;
;; != When checking different data types, be sure to
;;    check if it's an actual type (if you just use `string=?`,
;;    and try and pass a Number, it'll throw an error!
;;    - See: `(show x)`

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

;; Exercise 53, 54, 55, 56, 57
;; ---------------------------
;; Design a program that launches a rocket
;; + When user presses space bar
;;
;; - "resting"
;; - a Number between -3 and -1
;; - a NonnegativeNumber
;; interpretation a grounded rocket, in countdown mode,
;; a number denotes the number of pixels between the
;; top of the canvas and the rocket (its height)
;;
;; 1. Draw out the states
;; 2. Write out a wishlist
;; 3. Use the correct conditions for each sub-class of type

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3) ; Sets the speed of launch
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))
(define BOTTOM (- HEIGHT CENTER))
    


; Number/String -> Boolean
; Is it time to countdown?
(check-expect (countdown? "resting") #false)
(check-expect (countdown? -2) #true)
(define (countdown? x)
  (cond
    [(and (number? x)
          (<= -3 x -1)) #true]
    [else #false]))



; LRCD -> Image
; Split out the place-image function
; - DRY!
(define (render-rocket x)
  (place-image ROCKET (/ WIDTH 2) x BACKG))



; LRCD -> Image
; renders the state as a resting or flying rocket
; #3
(check-expect (show "resting")
              (render-rocket BOTTOM))
(check-expect (show -2)
              (place-image
               (text "-2" 20 "red")
               10 (* 3/4 WIDTH)
               (render-rocket BOTTOM)))
(check-expect (show 0)
              (render-rocket 0))
(check-expect (show 52)
              (render-rocket 52))

(define (show x)
   (cond
     [(and (string? x)
           (string=? "resting" x))
      (render-rocket BOTTOM)]
     [(<= -3 x -1)
      (place-image (text (number->string x) 20 "red")
                   10 (* 3/4 WIDTH)
                   (render-rocket BOTTOM))]
      [(>= x 0)
       (render-rocket x)]))



; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed,
; if the rocket is still resting
; — It should only produce a new WorldState when:
;   + it's state is "resting" ...
;   + AND a user hits the spacebar
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 "resting")]
    [(<= -3 x -1) x]
    [(>= 0) x]))
  


; LRCD -> LRCD
; raises the rocket by YDELTA,
; — only if it's moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -2) -1)
(check-expect (fly -1) BOTTOM)
(check-expect (fly 250) (- 250 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) BOTTOM (+ x 1))]
    [(>= x 0) (- x YDELTA)]))


; LRCD -> Boolean
; Stop the animation when the rocket is in space
(check-expect (space? 0) #true)
(check-expect (space? 200) #false)
(check-expect (space? "resting") #false)

(define (space? x)
  (if (and (number? x) (= 0 x))
      #true
      #false))


; LRCD -> LRCD
(define (main1 y)
  (big-bang y
    [to-draw show]
    [on-key launch]))


; LRCD -> LRCD
(define (main2 y)
  (big-bang y
    [to-draw show]
    [on-key launch]
    [on-tick fly 0.175]   ; Change "tick" rate
    [stop-when space?]))