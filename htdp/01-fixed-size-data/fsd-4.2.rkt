;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.2 Computing conditionally
;; ---------------------------
;;
;; `if` is best used if describing one-or-another case
;; `cond` is best used for multi-conditions
;;     + `else` for the exact opposite of all other conditions
;;     + if all conditions must be met, use an error!

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

; Exercises
; #1: Careful! `-1` gives false positive
; #2: Exercise 48

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))  ; #1

(check-expect (reward 10) "bronze")
(check-expect (reward 18) "silver")  ; #2
(check-error (reward -1))  ; #1

; Exercise 49
; — Cond inside another function

(define (inside y)
  (- 200 (cond [(> y 200) 0] [else y])))

(check-expect (inside 100) 100)
(check-expect (inside 210) 200)

; Rocket, revisited

(define WIDTH 100)
(define HEIGHT 60)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "io/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

; One way
(define (create-rocket-scene.v5 h)
   (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 h MTSCN)]
    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))
; Nested cond
(define (create-rocket-scene.v6 h)
  (place-image ROCKET 50 (cond [(<= h ROCKET-CENTER-TO-TOP) h]
                               [else ROCKET-CENTER-TO-TOP]) MTSCN))