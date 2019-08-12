;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.1 Other itemizations
;; ======================
;; #!: There are many ways to represent data and states
;;
;;     != How you structure your data representation
;;        has a big effect on the rest of your functions/program
;;
;;        + see the various design recipies as a guideline.
;;
;; #!: Reduce repetition wherever you can
;;
;; #1: Not 100% sure if this is correct. You're inversing the
;;     exponent with log: https://math.stackexchange.com/a/956787
;;
;;     #! you may only need one or the other, i.e:
;;        space->cage or cage->space
;;
;; #2: Shouldn't I be able to just use the predicate,
;;     without the right-side or else?

(require 2htdp/image)
(require 2htdp/universe)

;; See previous files for earlier exercises
;; - they were too long to split properly into "ex. number" headings!





; Wish list
;; --------

; spider legs calculator?
; lost-tail calculator?
; stick to Cube only or have different sized cages?
; fits? needs to consume an animal-space and a Cage
;       - you may need an auxiliary func to determine
;         which animal ...
; split out maths functions? (cube ...) (inverse-cube ...)
; exact-round weird numbers (doesn't work in beginner lang)







;; Exercise 103
;; ============
;; Develop a data representation for 4 zoo animals

; Space is a Number
; represents the volume of a Cage

; Edge is a Number
; represents one side of a (square) Cage

(define-struct cage [edge])
; A Cage is a structure
;   (make-cage Edge)
; - Number is the edge of the 


; Cage -> Space
; converts a cage to a volume
(define (cage->space c)
  (expt (cage-edge c) 3))

(check-expect (cage->space (make-cage 3)) 27)

; Space -> Cage
; converts a Space to a Cage
(define (space->cage vol)
  (make-cage (inexact->exact (log vol 3)))) ; #1

(check-expect (space->cage 27) (make-cage 3))



(define-struct spider [legs space])
; A spider is a structure
;   (make-spider Number Space)
; - number of legs they have left
; - space they need in case of transport


; templ
(define (func-for-spider s)
  (... (spider-legs s)
       (spider-volume s)))


(define-struct elephant [space])
; An Elephant is a structure
;    (make-elephant Space)
; - the space they need in case of transport


(define-struct boa [length girth])
; A boa constrictor is a structure
;   (make-constrictor Number Number)
; length and girth


(define-struct armadillo [tail body space])
; An Armadillo is a structure
;    (make-armadillo Number Number Space]
; - some poor bastards have lost their tail




;; Consuming the animals
;; =====================

; Animals -> ???
; template to consume whatever animal you throw at it
(define (func-for-animals a)
  (... (func-for-spider ...)
       (func-for-elephant ...)
       (func-for-boa ...)
       (func-for-armadillo ...)))

; needs extracting attributes  #!

(define (animal-space a)
  ...)


;; Checking space
;; ==============

; Animal Cage -> Boolean?
; determines if cages volume is large enough for Animal
(define (fits? a c)
  (cond
    [(<= (elephant-space a) 
         (cage->space c)) #true]  ; #1, #2
    [else #false]))