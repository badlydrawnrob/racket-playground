;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rocket-example-draw!) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Here's the constants

(define WIDTH 180)
(define HEIGHT 180)
(define MIDDLE (/ WIDTH 2))

(define BACKGROUND
  (rectangle WIDTH HEIGHT "solid" "black"))

(define ROCKET
  (bitmap/file "rocket.png"))

(define MOON
  (circle 40 "solid" "white"))

; Let's make our image!

(place-image
  ROCKET MIDDLE MIDDLE
    (place-image
      MOON 10 10
        BACKGROUND))