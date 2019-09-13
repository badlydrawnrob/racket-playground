;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 6.4 Checking the world
;;;; ======================
;;;; What went wrong?
;;;;
;;;; A full program has lots of moving parts and
;;;; lots of room for error (somewhere in the chain)
;;;;
;;;; #1: If any world state returns anything except a Number
;;;;     an error is flagged.
;;;;
;;;; #2: Something a bit more useful than a data-definition
;;;;     i.e: is it in range of an interval?

(require 2htdp/image)
(require 2htdp/universe)


;;; Demo
;;; ----
;;; big-bang and check-with

;; World State is a Number
;; WS -> WS
(define (main s0)
  (big-bang s0
    [to-draw ...]
    [check-with number?])) ; #1


; A UnitWorld is a number
;   between 0 (inclusive) and 1 (exclusive)

; Any -> Boolean
; is x between 0 (inclusive) and 1 (exclusive)
(define (between-0-and-1? n)
  (and (number? n)
       (or (= 0 n)
           (< 0 n 1))))

(check-expect (between-0-and-1? "a") #false)
(check-expect (between-0-and-1? 1.2) #false)
(check-expect (between-0-and-1? 0.2) #true)
(check-expect (between-0-and-1? 0.0) #true)
(check-expect (between-0-and-1? 1.0) #false)
