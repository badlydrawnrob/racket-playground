;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.11 More Virtual Pets
;; ======================
;;
;; != Create the structures EARLY in the chain
;;    - rather than passing around half structures
;;    - everything else passes raw values
;;
;; != Constants should really be `graphic` and `world`

(require 2htdp/image)
(require 2htdp/universe)


;; Constants
;; ---------

(define W-WIDTH 400)
(define W-HEIGHT 150)
(define CAT-HEIGHT (+ 10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10)

(define CAT (bitmap "io/cat1.png"))

(define MT
  (empty-scene W-WIDTH W-HEIGHT))

(define SPEED 3)



;; Exercise 88
;; -----------

(define-struct vcat [pos happy])
; A VCat is a structure
;   (make-vcat Number Number[0,100])
; Creates an instance with an x-coordinate
; and a happiness level

(define CAT1 (make-vcat 0 100))
(define CAT2 (make-vcat 50 50))
(define CAT3 (make-vcat W-WIDTH 0))




;; Exercise 89
;; -----------
;; Recycle previous exercise
;; and add a universe


; Cat -> Image
; render the cat on the background
; render the happiness gauge, too
(define (render vc)
  (place-image/align
   (rectangle (vcat-happy vc) G-HEIGHT "solid" "red")
   5 10 "left" "top"
   (place-image CAT (vcat-pos vc) CAT-HEIGHT MT)))




;; Wish list
;; ---------

; tock function
; - make cat
; - move cat
; - reduce happiness

; VCat -> VCat
; basic shell for structure instance
(define (tock vc)
  (make-vcat (tock-move (vcat-pos vc))
             (tock-happy (vcat-happy vc))))


; Number -> Number
; move the cat ...
(define (tock-move num)
  (cond
    [(< num W-WIDTH) (+ num 3)]
    [else 0])) ; reset

(check-expect (tock-move 0.0) 3.0)
(check-expect (tock-move W-WIDTH) 0.0)


; Number -> Number
; reduce happiness
; range [0, 100]
(define (tock-happy num)
  (cond
    [(> num 0.0) (- num 0.1)]
    [else 0.0]))

(check-expect (tock-happy 0.1) 0.0)
(check-expect (tock-happy 10.0) 9.9)
(check-expect (tock-happy 0.0) 0.0)



; render function
; - image



; VCat -> VCat
; pet or feed the cat for more happiness
; - "up"
; - "down"
; - nothing
(define (happiness vc ke)
  (cond
    [(key=? ke "up") (more-happy vc)] ; pet
    [(key=? ke "down") (more-happy vc)] ; feed
    [else (make-vcat (vcat-pos vc) (vcat-happy vc))]))              

; VCat -> VCat
; increase happiness by 1
(define (more-happy vc)
  (make-vcat (vcat-pos vc) (+ (vcat-happy vc) 1.0)))

; unhappy?





;; LAUNCH PROGRAM
;; ==============


; VCat -> VCat
; launches programme from initial state
; - consumes a (make-vcat ...)
; - returns a (make-vcat ...)
(define (cat-prog vc)
  (big-bang vc
    [on-tick tock]
    [on-key ...]
    [to-draw ...]))