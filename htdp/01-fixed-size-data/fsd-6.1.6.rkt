;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1.6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.1 Other itemizations
;; ======================
;; Some functions have been considered, but not written
;; as design-decisions can get complex fast!
;;
;; #!: Where is origin?!
;;
;;     [0,0] with (place-image ...) is from-top-left
;;     [0,0] with a cartesian point is from-bottom-left
;;
;;     Your functions are dependent on your mental-model of
;;     the state and it's visual representation
;;
;; #1: We're using the from-top-left model, so we'd need to flip
;;     the NegativeNumber to a positive.


(require 2htdp/image)
(require 2htdp/universe)




; Wish list
; ---------
; 1. auxiliary function so graph-posn isn't repeated?
; 2. what other data representations could there be?




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

(define WIDTH 100)
(define HEIGHT 100)
(define BACKGROUND
  (empty-scene WIDTH HEIGHT))
(define CIRCLE
  (circle 1 "solid" "red"))

(define Y1 -5)
(define Y2 -25)
(define X1 5)
(define X2 15)


; NegativeNumber -> PositiveNumber
; auxiliary function for cartesian-point
(define (y-positive y)
  (abs y))

(check-expect (y-positive Y1) 5)

; PositiveNumber NegativeNumber -> Posn
; Takes two coordinates and returns a cartesian point
(define (cartesian-point x y)
  (make-posn x (y-positive y))) ; #1

(check-expect (cartesian-point X1 Y1) (make-posn 5 5))

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
(render (make-graph (cartesian-point X1 Y1) BACKGROUND))
(render (make-graph (cartesian-point X2 Y2) BACKGROUND))


            