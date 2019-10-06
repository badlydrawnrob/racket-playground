;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.1.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.1 Finger Exercises: Lists
;;;; ===========================
;;;;
;;;; ##: Careful of base cases for '() empty lists!
;;;;
;;;;     - '() should be #false here. If any value is #true,
;;;;       (or ...) will ALWAYS return #true.
;;;;     - For (and ...) function, it's the reverse.
;;;;
;;;; ##: Remember, you can think of the way a recursive function
;;;;     works in many ways:
;;;;
;;;;     - A tabular list (with progressive results)
;;;;     - Empty list -> full list (with each expected result)
;;;;
;;;; ##: Remember, it's easier to sketch out the whole function first!!!
;;;;     ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆

(require 2htdp/image)



;;; Exercise 142
;;; ------------
;;; Design the ill-sized? function, which consumes a
;;; list of images loi and a positive number n.
;;;
;;; - produce first image on loi that
;;; - is not n by n square
;;; - else #false

; ImageOrFalse is one of:
; - Image
; - #false

; List-of-images is one of:
; -'()
; - (cons ImageOrFalse List-of-Images)

(define IMG1 (bitmap "io/sizes/20x20.png"))
(define IMG2 (bitmap "io/sizes/30x30.png"))
(define IMG3 (bitmap "io/sizes/40x40.png"))
(define IMG4 (bitmap "io/sizes/30x40.png"))
(define IMG5 (bitmap "io/sizes/50x50.png"))
(define IMG6 (bitmap "io/sizes/40x50.png"))

(define LOI1 '()) ; #f
(define LOI2 (cons IMG1 LOI1))
(define LOI3 (cons IMG2 LOI2))
(define LOI4 (cons IMG3 LOI3))
(define LOI5 (cons IMG4 LOI4))
(define LOI6 (cons IMG5 LOI5))
(define LOI7 (cons IMG6 LOI6))

; LOI -> ImageOrFalse
; Takes a list, returns the image if not n by n; or false
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [else (if (not (image-square? (first loi) n))
              (first loi)
              (ill-sized? (rest loi) n))]))

(check-expect (ill-sized? LOI1 20) #f)
(check-expect (ill-sized? LOI2 20) #f)
(check-expect (ill-sized? LOI3 30) IMG1)
(check-expect (ill-sized? LOI4 40) IMG2)
(check-expect (ill-sized? LOI5 40) IMG4)
(check-expect (ill-sized? LOI6 50) IMG4)
(check-expect (ill-sized? LOI7 50) IMG6)

; Image Number -> Boolean
; Takes an image and a number, checks if n by n square
(define (image-square? img n)
  (and (equal? n (image-width img))
       (equal? n (image-height img))))

(check-expect (image-square? IMG1 20) #t) ; 20x20
(check-expect (image-square? IMG2 30) #t) ; 30x30
(check-expect (image-square? IMG3 30) #f) ; 40x40
(check-expect (image-square? IMG3 30) #f) ; 30x40


; LOI -> Boolean
; Checks if all list items are images
(define (is-loi? loi)
  (cond
    [(empty? loi) #true]
    [else (and (image? (first loi))
               (is-loi? (rest loi)))]))

(check-expect (is-loi? LOI1) #t)
(check-expect (is-loi? LOI2) #t)
(check-expect (is-loi? LOI3) #t)
(check-expect (is-loi? LOI4) #t)
(check-expect (is-loi? LOI5) #t)
(check-expect (is-loi? LOI6) #t)
(check-expect (is-loi? (cons (bitmap "io/sizes/20x20.png")
                             (cons "a" '()))) #f)

; LOI PositiveNumber -> ImageOrFalse
; A Type-tested check, passes to main function or dies
;(define (test-loi loi n)
;  (cond
;    [(is-loi? loi) (ill-sized? loi n)]
;    [else (error "Go and do your homework buddy!")]))

;(check-expect (test-loi LOI1) #t)
;(check-expect (test-loi LOI6) #t)
;(check-error (test-loi (cons (bitmap "io/sizes/20x20.png")
;                             (cons "a" '()))))