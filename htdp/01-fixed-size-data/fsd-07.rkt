;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-size-data-07) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 2.3 Composing functions
;; - Sample problem
;;
;; 1. What is the problem question?
;; 2. What are the component question parts?
;; 3. Create one function per task
;;
;; Uses negative multiplication: LOOK UP!

;; #1
(define (attendees ticket-price)
  (- 120 (* (- ticket-price 5.0) (/ 15 0.1))))

;; #2
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

;; #3
;; fixed price @ $180
;; per attendee @ $0.04
(define (cost ticket-price)
  (+ 180 (* 0.04 (attendees ticket-price))))

;; #4
;; Find profit
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
