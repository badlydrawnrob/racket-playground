;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-size-data-04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 2.0 Functions and Programs
;
; Variable, function definition,
; function application, function composition
;
; Most functions don't check for type
; - eg: (string-length 42) -> error
;
; != Use (check-expect ...)
; != See this github for answers: https://bit.ly/2JL327Z

(require 2htdp/image)


(define (some-string x)
  (string-ref x 2))

; Ex.11 != need more maths knowledge
; Ex.12 != think is length**3 but not sure


; Ex.13 Extract 1st string
(define (string-first s)
  (if (> (string-length s) 0) (string-ith s 0) (error "string is empty")))


; Ex.14 Extract last string
(define (string-last s)
  (if (> (string-length s) 0)
      (string-ith s (- (string-length s) 1))
      (error "string is empty")))


; Ex.15 "implication" boolean operation: https://stackoverflow.com/a/1823201
; If A is true, then B must be true: (or (not A) B)
(define (==> sunny friday)
  (if (or (equal? #false sunny) (equal? #true friday)) #true #false))


; Ex.16 Counts number of pixels in a given image
(define (image-area image)
  (if (image? image)
      (* (image-width image) (image-height image))
      (error "you didn't enter an image, you dope!")))


; Ex.17 Return dimensions of image
; Output and frame the image — (image? ..) conditional is a little useless here
; - could also use (cond ..) here
(define (image-classify image)
  (if (< (image-width image) (image-height image))
      (output-image image "tall")
      (if (> (image-width image) (image-height image))
          (output-image image "wide")
          (output-image image "square"))))

(define (output-image image image-note)
  (if (image? image)
      (beside image (text image-note 16 "blue"))
      (error "this is not an image")))


; Ex.18 Take two strings and add "_" in between
(define (string-join str-1 str-2)
  (if (and (string? str-1) (string? str-2))
      (string-append str-1 "_" str-2)
      (error "Please enter two strings")))


; Ex.19 Insert a string at ith position
; Only if `i` is within range (and not just whitespace)
; != Breaks for negative numbers
; != 1. (explode s)
;       + Insert at position i ... (list-ref x i)
; != 2. (implode s) with "_" at position i?
(define (string-insert str i)
  (if (and (>= (string-length str) i)
           (not (string-whitespace? str)))
      "this is cool"
      (error "this is not")))