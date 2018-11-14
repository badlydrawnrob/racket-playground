;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-size-date-05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 2.2 Computing
;; -------------
;; Using the steper
;;
;; 1. Highlight code to step through
;; 2. Select "Jump to ... beginning of selected"

(require 2htdp/image)



;; Simple function example
(define (ff i)
  (* 10 i))

;; Let's mix it up ...
(define (length-of-string str)
  (if (string? str)
      (string-length str)
      (error "this is not a string")))

;; Then compute `ff` with len(str)
(ff (length-of-string "a long string"))


;; Ex. 21 — Nested `ff` function
;; Seeing how Dr. Rackets stepper works ..

(ff (ff 1))
(+ (ff 1) (ff 1))


;; Example from book: A letter

(define (opening first-name last-name)
  (string-append "Dear " first-name ","))

(opening "Someone" "Else")


;; Ex.22 Calculate distance to origin
;; Use stepper on this program fragment
;; @link: https://bit.ly/2qB1LHy

(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))
(distance-to-origin 3 4)

;; Ex.23 How does this function compute
;; the result of 1String in "hello world"?

(define (string-first s)
  (substring s 0 1))

(string-first "hello world")


;; Ex.24 "implication" boolean operation:
;; if A is true, then B must be true!
;; @link: https://stackoverflow.com/a/1823201
(define (==> x y)
  (or (not x) y))

(==> #true #false)

; (define (==> sunny friday)
;  (if (or (equal? #false sunny) (equal? #true friday)) #true #false))


;; Ex.25 Alternative route for image-classify
;; Step through, does it need fixing?
;; @fix: (>= (image-height ...) should be (> ...)

(define (image-classify img)
  (cond
    [(> (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(< (image-height img) (image-width img)) "wide"]))

(define tall-image (rectangle 20 40 "solid" "purple"))
(define square-image (circle 30 "outline" "purple"))
(define wide-image (ellipse 50 20 "outline" "purple"))

(image-classify wide-image)


;; Ex.26 What do you expect as the value of this program?

(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))

(string-insert "helloworld" 6)


