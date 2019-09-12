;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.3.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 6.3 Input Errors
;;;; ================
;;;; predicates critical when functions process
;;;; a data mix, or passing functions around, or apis,
;;;; or HUMAN ERROR!
;;;;
;;;; #! Writing your tests first can be helpful!
;;;;
;;;; #! Predicates consume ALL POSSIBLE BSL values
;;;;    so you need to take care with type-checking and
;;;;    user error.
;;;;
;;;;    Any -> Boolean
;;;;    Any Any -> Boolean
;;;;
;;;;    Of course a struct has a built in predicate, but if
;;;;    you need to check its INTERNAL details (PosNum NegNum) it's
;;;;    best to pass RAW VALUES (rather than Struct -> Boolean)
;;;;
;;;;
;;;; #1: You don't need to include all variables
;;;;     just those that you need to check against ...
;;;;
;;;;     - is it #false (could be shortedned using (false? v)
;;;;     - or a Posn
;;;;
;;;;     Those are the only two values allowed, else #false

(require 2htdp/image)
(require 2htdp/universe)


;;; Demo
;;; ----

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; What happens if user enters wrong TYPE?
; > (area-of-disk "3")
; "..." error text


;;; Any TYPE
;;; --------
;;; The universe of data is big, even in BSL
;;; we could add checks for each type
;;;
;;; (make-posn Any Any)
;;; (make-tank An y Any)

; Any -> ???
(define (checked-f v)
  (cond
    [(number? v) ...]
    [(boolean? v) ...]
    [(string? v) ...]
    [(image? v) ...]
    [(posn? v) (...(posn-x v) ... (posn-y v) ...)]))

;;; But that's a dumb idea.
;;; - Throw an error if not TYPE

(define MESSAGE "area-of-disk: number expected")

(define (typed-area-of-disk r)
  (cond
    [(number? r) (* 3.14 (* r r))]
    [else (error MESSAGE)]))




;;; Exercise 110
;;; ------------

(define (positive-area-of-disk r)
  (cond
    [(and (number? r)
          (positive? r)) (* 3.14 (* r r))]
    [else (error MESSAGE)]))



;;; Exercise 111
;;; ------------

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define MESSAGE2 "you did a booboo")

; Vec -> Boolean
(define (checked-make-vec v)
  (cond
    [(and (and (number? (vec-x v))
               (positive? (vec-x v)))
          (and (number? (vec-y v))
               (positive? (vec-y v))))
     (make-vec (vec-x v) (vec-y v))]
    [else MESSAGE2]))

; Probably better to do:
; ----------------------

; Any Any -> Boolean
(define (better-checked-make-vec n1 n2)
  ...)


(define VEC1 (make-vec 1 1))
(define VEC2 (make-vec 0 0))
(define VEC3 (make-vec -1 1))
(define VEC4 (make-vec 1 -1))

(check-expect (checked-make-vec VEC1) VEC1)
(check-expect (checked-make-vec VEC2) MESSAGE2)
(check-expect (checked-make-vec VEC3) MESSAGE2)
(check-expect (checked-make-vec VEC4) MESSAGE2)




;;; Roll your own predicate
;;; -----------------------
;;; For instance, MissileOrNot
;;; Stay consistant, use "?" to show predicate ...

; MissileOrNot is one of:
; - #false
; - Posn

; Any -> Boolean
; is a an element of the MissileOrNot collection
; (define (missile-or-not? a) #false)  ; stub

;; WRONG!

(define (wrong-missile-or-not? v)
  (cond
    [(boolean? v) ...]
    [(posn? v) (... (posn-x v) ... (posn-y v) ...)]
    [else #false]))

;; CORRECT!

(define (missile-or-not? v)
  (cond
    [(boolean? v) (boolean=? #false v)]  ; #1
    [(posn? v) #true]
    [else #false]))


(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? 10) #false)
(check-expect (missile-or-not? empty-image) #false)


;;; Exercise 112
;;; ------------
;;; Use an OR expression instead

(define (or-missile-or-not? v)
  (cond
    [(or (false? v)
         (posn? v)) #true]
    [else #false]))



;;; Exercise 113
;;; ------------
;;; Create predicates for prev. data definitions

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define (sigs? s)
  (cond
    [(or (aim? s)
         (fired? s)) #true]
    [else #false]))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define-struct coordinate [neg pos posn])

(define COORD1 (make-coordinate -1 1 (make-posn 1 1)))
(define COORD2 (make-coordinate 1 1 (make-posn 1 1)))
(define COORD3 (make-coordinate -1 1 #false))
(define COORD4 (make-coordinate  -1 0 (make-posn 1 1)))

(define (safe-coordinate? c1 c2 c3)
  (cond
    [(< c1 0) #true]
    [(> c2 1) #true]
    [(posn? c3) #true]
    [else #false]))


(check-expect (safe-coordinate? (coordinate-neg COORD1)
                                (coordinate-pos COORD1)
                                (coordinate-posn COORD1)) #true)
(check-expect (safe-coordinate? (coordinate-neg COORD2)
                                (coordinate-pos COORD2)
                                (coordinate-posn COORD2)) #false)
(check-expect (safe-coordinate? (coordinate-neg COORD3)
                                (coordinate-pos COORD3)
                                (coordinate-posn COORD3)) #false)
(check-expect (safe-coordinate? (coordinate-neg COORD4)
                                (coordinate-pos COORD4)
                                (coordinate-posn COORD4)) #false)