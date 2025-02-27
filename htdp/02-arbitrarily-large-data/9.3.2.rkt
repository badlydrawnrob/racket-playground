;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.3.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.3 Natural Numbers
;;;; ===================
;;;;
;;;; 1. Sketch out the problem first,
;;;; 2. Write problem as lists->results table, or empty->full method
;;;; 3. Use design recipe
;;;; 4. Double check your base cases!
;;;; 5. Do you need to split out functions?
;;;; 6. How will you deal with empty lists?
;;;;
;;;;
;;;; ##: Beware of infinite loops!
;;;;
;;;;     Without type checking the condition as a positive number,
;;;;     the wrong type will throw a spanner in the works.
;;;;
;;;;
;;;; ##: Things can go into Matrix territory with recursion!
;;;;
;;;;     - Is it best to avoid nested recursion?
;;;;



(require 2htdp/image)


;;; Exercise 152
;;; ------------

(define box (square 10 "outline" "black"))

; N Image -> Image
; create n columns of image
(define (col n img)
  (cond
    [(zero? n) empty-image]                           ; 0
    [(positive? n) (beside img (col (sub1 n) img))])) ; above

(check-expect (col 2 box) (beside box box empty-image))

; N Image -> Image
; create n rows of image
(define (row n img)
  (cond
    [(zero? n) empty-image]                          ; 0
    [(positive? n) (above img (row (sub1 n) img))])) ; beside

(check-expect (row 4 box) (above box box box box empty-image))



;;; Exercise 153
;;; ------------

(define ROWS 18)
(define COLS 8)
(define CELL-SIZE 10)

;; graphical constants
(define CELL (square CELL-SIZE "outline" "black"))
(define BALLOON (circle 3 "solid" "red"))

(define BACKGROUND (empty-scene (* CELL-SIZE COLS) (* CELL-SIZE ROWS) "white"))

;; A row of CELLS
(define ROW (col COLS CELL))

;; A col of CELLS
(define COL (row ROWS ROW)) ; pass in image generated by ROW

;; Background
(define HALL
  (place-image COL
               (/ (image-width BACKGROUND) 2)
               (/ (image-height BACKGROUND) 2)
               BACKGROUND))

;; Data

;; List-of-Posns is one of
;; - '()
;; - (cons Posn '())

(define NONE '())
(define ONE (cons (make-posn 10 10) '()))
(define THREE (cons (make-posn 10 10)
                    (cons (make-posn 20 20)
                          (cons (make-posn 30 30) '()))))

;; Functions

;; List-of-Posns -> Image
;; place PAINT images at Posn locations given a List-of-Posns
(check-expect (add-balloons '())
              HALL)

(check-expect (add-balloons ONE)
              (place-image BALLOON 10 10
                           HALL))

(check-expect (add-balloons THREE)
              (place-image BALLOON 10 10
                           (place-image BALLOON 20 20
                                        (place-image BALLOON 30 30
                                                     HALL))))

; (define (add-balloons lop) empty-image)

(define (add-balloons lop)
  (cond [(empty? lop) HALL]
        [else
         (place-image BALLOON
                      (posn-x (first lop))
                      (posn-y (first lop))
                      (add-balloons (rest lop)))]))


;; Final example image
(define FINAL-IMAGE
  (add-balloons (list (make-posn 10 20)
                      (make-posn 20 40)
                      (make-posn 30 60)
                      (make-posn 40 80)
                      (make-posn 50 100)
                      (make-posn 60 120)
                      (make-posn 70 140)
                      (make-posn 80 160)))) ; Last ballon is off-screen

FINAL-IMAGE