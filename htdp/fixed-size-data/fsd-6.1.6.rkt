;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.1 Other itemizations
;; ======================
;; Some functions have been considered, but not written
;; as design-decisions can get complex fast!

(require 2htdp/image)
(require 2htdp/universe)


;; Exercise 105
;; ============
;; 1. Make at least two data examples per clause in the
;;    data definition.
;; 2. Draw a sketch to explain each example's meaning.

; A Coordinate is one of:
; - a NegativeNumber
; interpretation on the y axis, distance from top
; - a PositiveNumber
; interpretation on the x axis, distance from left
; - a Posn
; interpretation and ordinary Cartesian point

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND
  (empty-scene WIDTH HEIGHT))
(define CIRCLE
  (circle 1 "solid" "red"))


; NegativeNumber -> NegativeNumber
(define (y-co y) y)
; (define-struct y-coordinate [n])

(check-expect (y-co -1) -1)

; NegativeNumber -> PositiveNumber
; auxiliary function for cartesian-point
(define (y-positive y)
  (abs y))

(check-expect (y-positive -1) 1)

; PositiveNumber -> PositiveNumber
(define (x-co x) x)
; (define-struct x-coordinate [x])

(check-expect (x-co 5) 5)


; PositiveNumber NegativeNumber -> Posn
; Takes two coordinates and returns a cartesian point
(define (cartesian-point x y)
  (make-posn x (y-positive y)))

(check-expect (cartesian-point (x-co 5) (y-co -5)) (make-posn 5 5))

(define-struct graph [posn img])
; A graph is a structure
;   (make-graph Posn Img)
; Posn plots the coordinates
; img sets the scene

; temp
(define (func-for-graph g)
 (... (graph-posn g)
      (graph-img g)))


; Graph -> Image
; Creates an image from a Graph
(define (render g)
  (place-image CIRCLE
               (posn-x (graph-posn g)) (posn-y (graph-posn g))
               (graph-img g)))

; Test it
(render (make-graph (cartesian-point (x-co 20) (y-co -25)) BACKGROUND))


; Wish list
; 1. auxiliary function so graph-posn isn't repeated?
; 2. do I need to give other data representations?
            