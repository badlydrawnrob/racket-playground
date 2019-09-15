;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.3 Enumerations
;; ================
;; An enumeration is a type of data where all possiblities are listed:
;; 
;; A MouseEvt is one of these Strings:
;; – "button-down"
;; – "button-up"
;; – "drag"
;; – "move"
;; – "enter"
;; – "leave"
;;
;; + It's generally wise to use:
;;   - A cond statement only what matters (the keys we'll use)
;;   - else (for everything else!)

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Traffic light example:
;; ----------------------
;; Data definition of traffic light

; A TrafficLight is one of the following Strings:
; - "red"
; - "green"
; - "yellow"
; interpretation: represents the states a traffic light could be
;                 + a simplistic version

; TrafficLight -> TrafficLight
; yields next state given current state
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next color)
  (cond
    [(string=? "red" color) "green"]
    [(string=? "green" color) "yellow"]
    [(string=? "yellow" color) "red"]))

;; Exercise 50
;; -----------
;; Make sure all tests are run and pass (see above)

;; Exercise 51
;; -----------
;; Make a big-bang version of the traffic lights
;; #1: 3 seconds between frames
;;     stop at 18 seconds

; A solid circle of color
; - set the color to the correct state
; - change the color on each clock tick
; - set the initial state

(define WIDTH 30)
(define (render-traffic-light color)
  (circle WIDTH "solid" color))

; A Color is a String
; interpretation the current state of a TrafficLight

; Color -> Color
(define (main color)
  (big-bang color
    [to-draw render-traffic-light]
    [on-tick traffic-light-next 3 3]))  ; #1


;; 1 string example:
;; -----------------
;; A sentence that describes the elements to enumerate
;; but doesn't note all of them

; A 1String is a String of length 1, 
; including
; – "\\" (the backslash),
; – " " (the space bar), 
; – "\t" (tab),
; – "\r" (return), and 
; – "\b" (backspace).
; interpretation represents keys on the keyboard

(check-expect (is-1string? " ") #true)
(check-expect (is-1string? "nope") #false)
(define (is-1string? s)
  (= (string-length s) 1))

