;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.11 More Virtual Pets
;; ======================
;;
;; != Constants should really be `graphic` and `world`
;;
;; #1: Start the animation again
;;     != I think you only need to "make a vcat" in this one place?

(require 2htdp/image)
(require 2htdp/universe)


;; Constants
;; ---------
(define HAPPY 100)
(define MEDIUM 50)
(define SAD 0)

(define CAT (bitmap "io/cat1.png"))
(define WIDTH (image-width CAT))
(define HEIGHT (image-height CAT))
(define Y-HEIGHT (/ HEIGHT 2))
(define BACKGROUND-WIDTH (* WIDTH 5))
(define X-GAUGE (* WIDTH 4))

(define BACKGROUND
  (rectangle BACKGROUND-WIDTH HEIGHT "solid" "white"))



;; Exercise 88
;; -----------

(define-struct vcat [pos happy])
; A VCat is a structure
;   (make-vcat Number Number)
; Creates an instance with an x-coordinate
; and a happiness level

(define HAP-CAT (make-vcat 0 HAPPY))
(define MID-CAT (make-vcat 0 MEDIUM))
(define SAD-CAT (make-vcat 0 SAD))


;; Exercise 89
;; -----------
;; Recycle previous exercise
;; and add a universe


; VCat -> Image
; render the happiness gauge
(define (happiness vc)
  (overlay/align
    "middle" "bottom"
    (rectangle 10 (vcat-happy vc) "solid" "red")
    (rectangle 10 HEIGHT "solid" "gray")))


; VCat -> Image
; render the cat on the background
; render the happiness gauge, too
(define (render-background vc)
  (place-image
    CAT
    (vcat-pos vc) Y-HEIGHT
    (place-image
      (happiness vc)
      HEIGHT X-GAUGE
      BACKGROUND)))
  

; VCat -> VCat
; move the cat by 3px for each clock tick
; reduce the happiness for each clock tick
(define (render vc)
  (make-vcat (move-cat vs) (happy-))  ; #1

; VCat -> VCat
; move the cat by 3px for each clock tick
(define (move-cat ws)
  (cond
    [(< ws BACKGROUND-WIDTH) (+ ws 3)]
    [else 0]))

(check-expect (move-cat 0) 3)
(check-expect (move-cat BACKGROUND-WIDTH) (make-vcat 0 0))



; VCat -> VCat
; increase or decrease the happiness
; - pet it (up)
; - feed it (down)
(define (happy-level vc)
  (cond
    [(key=? "up" vc) (more-happy vc)]
    [(key=? "down" vc) (more-happy vc)]
    [else (make-cat (vcat-pos vc) (vcat-happy vc))]))


; VCat -> Boolean?
; is the figure between 0-100?
(define (range? vc)
  (and (> 0 (vcat-happy vc)) (<= (vcat-happy vc) 100)))

(check-expect (happy? (+ HAPPY 1)) #false)
(check-expect (happy? HAPPY) #true)
(check-expect (happy? MEDIUM) #true)
(check-expect (happy? SAD) #false)

                
; VCat -> VCat
; petting or feeding the cat makes it happy
; - it can only be 0—100
(define (more-happy vc)
  (cond
    [(range? (vcat vc)) (make-vcat (vcat-pos vc) (+ (vcat-happy vc) 1))]
    [(make-vcat (vcat-pos vc) (vcat-happy vc))]))

(check-expect (pet-cat HAP-CAT) (make-vcat 0 99))
(check-expect (pet-cat MID-CAT) (make-vcat 0 51))
(check-expect (pet-cat SAD-CAT) SAD-CAT)


; VCat -> VCat
; launches programme from initial state
; - consumes a (make-vcat ...)
; - returns a (make-vcat ...)
(define (cat-prog vc)
  (big-bang vc
    [on-tick move-cat]
    [on-key happy-level]
    [to-draw render-cat]))