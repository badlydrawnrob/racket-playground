;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.1.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 6.1 Other itemizations
;; ======================
;; Some functions have been considered, but not written
;; as design-decisions can get complex fast!
;;
;; #!: See wishlist for possible routes
;;
;; #!: There are many ways to represent data and states
;;
;;     How you structure your data representation
;;     has a big effect on the rest of your functions/program
;;
;;     + see the various design recipies as a guideline.
;;
;; #!: Reduce repetition wherever you can
;;
;;     + It's not entirely necessary to split out the maths functions
;;       but it does make them reusable and reduces nesting!
;;
;; #1: Not 100% sure if this is correct. You're inversing the
;;     exponent with log: https://math.stackexchange.com/a/956787
;;
;;     #! you may only need one or the other, i.e:
;;        space->cage or cage->space
;;
;;     #! also, <= may make it a very tight squeeze!
;;
;; #2: It may be that you ALWAYS need a conditional "question"
;;     and an "answer" (left side, right side) ... you can use a
;;     predicate on the right side, but possible not just a single
;;     predicate per condition (only a left side)
;;
;;     #! we make sure to have every possibile (enumeration?)
;;        option catered for ...

(require 2htdp/image)
(require 2htdp/universe)

;; See previous files for earlier exercises
;; - they were too long to split properly into "ex. number" headings!





;; Wish list
;; =========
;; Some possible routes that we could build out

; 1. A spider legs calculator?
; 2. A lost-tail calculator?
; 3. Different sized cages (not just a cubic box)
; 4. fits? consumes an animal-space and a cage
;    - auxiliary function could be used to determine
;      which animal it is, if the (cond ...) needs to
;      return a more complicated value.
;    - for instance, you may need to run #1 or #2
;      to re-calculate animal-space
; 5. (exact-round ...) doesn't work in beginner language
;    - @link: https://stackoverflow.com/a/35381207
; 6. It might be a tight squeeze! Should we give each
;    animal some space to walk around?




;; Exercise 103
;; ============
;; Develop a data representation for 4 zoo animals




;; Types
;; -----

; Space is a Number
; represents the volume of a Cage

; Edge is a Number
; represents one side of a (square) Cage

; Volume is a Number
; represents a cubic volume




;; The Cage
;; --------

(define-struct cage [edge])
; A Cage is a structure
;   (make-cage Edge)
; - Number is the edge of the 


; Cage -> Space
; converts a cage to a volume
(define (cage->space c)
  (cube (cage-edge c)))

(check-expect (cage->space (make-cage 3)) 27)

; Edge -> Volume
; convert a cube's edge to it's volume
(define (cube e)
  (expt e 3))  ; #!

(check-expect (cube 3) 27)


; Space -> Cage
; converts a Space to a Cage
(define (space->cage vol)
  (make-cage (reverse-cube vol)))

(check-expect (space->cage 27) (make-cage 3))

; Volume -> Edge
; converts to a cube's edge
(define (reverse-cube vol)
  (inexact->exact (log vol 3)))  ; #1

(check-expect (reverse-cube 27) 3)







;; The animals
;; -----------

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

(define (boa-space b) (* (boa-length b) (boa-girth b)))

(define-struct armadillo [tail body space])
; An Armadillo is a structure
;    (make-armadillo Number Number Space]
; - some poor bastards have lost their tail




;; Checking the space
;; ------------------

; Animals -> ???
; you want a conditional template to ask:
; - which animal is it?
(define (func-for-animals a)
  (cond
    [(spider? a) ...]
    [(elephant? a) ...]
    [(boa? a) ...]
    [(armadillo? a) ...]))


;; Tests for fits?
(check-expect (fits? (make-spider 6 5)
                     (make-cage 1)) #false)
(check-expect (fits? (make-elephant 200)
                     (make-cage 6)) #true)
(check-expect (fits? (make-boa 5 10)
                     (make-cage 3.5)) #false)
(check-expect (fits? (make-armadillo 6 4 (* 6 4))  ; #!
                     (make-cage 3)) #true)


; Animal Cage -> Boolean?
; determines if cages volume is large enough for Animal
(define (fits? a c)
  (cond
    [(spider? a) (<= (spider-space a) (cage->space c))]  ; #1, #2
    [(elephant? a) (<= (elephant-space a) (cage->space c))]
    [(boa? a) (<= (boa-space a) (cage->space c))]
    [(armadillo? a) (<= (armadillo-space a) (cage->space c))]))
