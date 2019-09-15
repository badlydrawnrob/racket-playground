;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 6.5 Equality Predicates
;;;; =======================
;;;; A function that compares two elements of
;;;; same collection of data ...
;;;;
;;;; #! Use (key=? ...) and (mouse=? ...) from now on!
;;;;
;;;;    - Your own equality predicates may not be used much,
;;;;      but these are very useful
;;;;
;;;; #! What if a equality predicate is given the wrong
;;;;    type of string?
;;;;
;;;;    1. check against a predicate with conditions
;;;;    2. equality predicate with an ERROR message (if not Type)
;;;;
;;;;
;;;; #! Use (check-error ...) when checking for errors
;;;;
;;;;
;;;; #1: To check both answers you use nested IF conditions
;;;;     @link: https://bit.ly/2mgTGcj

(require 2htdp/universe)
(require 2htdp/image)



;;; Demo
;;; ----

; A TrafficLight is one of
; - "red"
; - "green"
; - "yellow"

; TrafficLight TrafficLight -> Boolean
; are the two (states of) traffic lights equal
(define (light=? l1 l2)
  (string=? l1 l2))

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)

; #!
; (light=? "salad" "greens")
; (light=? "beans" 10)


;; Properly check if string belongs to TrafficLight
;; ------------------------------------------------
;; If not, raise the proper error

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

;; Create an error string
(define MESSAGE "string=? expects a TrafficLight")

; TrafficLight TrafficLight -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal
(define (light-checked=? l1 l2)
  (if (and (light? l1) (light? l2))
      (string=? l1 l2)
      (error MESSAGE)))

(check-expect (light-checked=? "red" "red") #true)
(check-error (light-checked=? 10 #false) MESSAGE)         ; #!
(check-error (light-checked=? "orange" "purple") MESSAGE) ; #!
(check-expect (light-checked=? "yellow" "green") #false)



;;; Exercise 115
;;; ============

(define MESSAGE1 "TrafficLight expected for parameter 1")
(define MESSAGE2 "TrafficLight expected for parameter 2")

(check-error (light-checked-both=? "blue" "red") MESSAGE1)
(check-error (light-checked-both=? "red" "blue") MESSAGE2)
(check-expect (light-checked-both=? "red" "red") #true)

; #1
(define (light-checked-both=? l1 l2)
  (if (light? l1)
      (if (light? l2)
          (string=? l1 l2)
          (error MESSAGE2))
      (error MESSAGE1)))