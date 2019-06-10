;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.8.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.8 Designing with Structures
;; =============================
;;
;; Read the update design recipe:
;; - @link: ./__README-02.md
;;
;; For types of data that are a whole "thing"
;; (i.e. an "object") USE A STRUCTURE
;; ------------------------------------------
;; - consume the structure with a function
;; - use design recipe to build the function
;;   - data consumed/output and function header
;;   - write down available data in a dummy template
;;     - (even if you don't need all of them)
;; - TEST that motherfucker
;;

(require 2htdp/universe)
(require 2htdp/image)



;; Exercise 81
;; ===========

(define-struct time [hours minutes seconds])
; Time is (make-time Number Number Number)
; interpretation:
;    The time that's passed since midnight
;    hours, minutes, seconds (with 2 integers each)

; Time -> Number
; outputs number of seconds that have passed since midnight
(define (time->seconds t)
  (+ (minutes->seconds (hours->minutes (time-hours t)))
     (minutes->seconds (time-minutes t))
     (time-seconds t)))

(define (minutes->seconds m)
  (* m 60))

(define (hours->minutes h)
  (* h 60))

(check-expect (time->seconds (make-time 1 1 0)) 3660)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds (make-time 5 29 13)) 19753)
