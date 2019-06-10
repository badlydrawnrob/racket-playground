;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.8 Designing with Structures
;; =============================
;;
;; Read the update design recipe:
;; - @link: ./__README-02.md
;;
;; For types of data that are a whole "thing"
;; (i.e. an "object") USE A STRUCTURE
;; ------------------------------------------
;; - consume the structure with a function
;; - use design recipe to build the function
;;   - data consumed/output and function header
;;   - write down available data in a dummy template
;;     - (even if you don't need all of them)
;; - TEST that motherfucker
;;
;;
;; #1: != Should the (sqr ...) be split out?
;; #2: != These tests are possibly written wrong
;;        - re-read the documentation

(require 2htdp/universe)
(require 2htdp/image)


;; Sample problem
;; --------------


(define-struct r3 [x y z])
; An R3 is a structure:
;    (make-r3 Number Number Number)
; interpretation:
;    Distance of objects in a
;    3-dimensional space to origin
;    using the x, y, z (depth?) coordinates
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number
; determines the distance of p to the origin
(define (r3-distance-to-0-TEMPLATE p)
  (... (r3-x p) .. (r3-y p) ... (r3-z p) ...))

; build the real function ...
; ---------------------------
(define (r3-distance-to-0 p)
  (sqrt (+ (sqr (r3-x p))
           (sqr (r3-y p))
           (sqr (r3-z p)))))    ; #1


(check-within (r3-distance-to-0 (make-r3 0 0 0)) 0 0.01)           ; #2
(check-within (inexact->exact (r3-distance-to-0 ex1)) 13.19 0.01)  ; #2
(check-within (inexact->exact (r3-distance-to-0 ex2)) 3.163 0.01)  ; #2





;; Exercise 80
;; ===========

(define-struct movie [title director year])
; A Movie is a structure:
;   (make-movie String String Number)
; interpretation:
;   A movie with a title, director and year of release

; Movie -> String
; outputs the movie information
(define (output-movie m)
  (... (movie-title m) ... (movie-director ... (movie-year) ...)))


(define-struct pet [name number])
; A Pet is a structure:
;   (make-pet String Number)
; interpretation:
;   Generates an instance of pet,
;   with a name and id number

; Pet -> String
; outputs the pet information
(define (output-pet p)
  (... (pet-name p) ... (pet-year) ...))


(define-struct CD [artist title price])
; A CD is a structure:
;   (make-pet String String Number)
; interpretation:
;   An instance of a CD with the artist, title and price

; CD -> Number
; outputs the price of the CD
(define (output-cd cd)
  (... (cd-artist cd) ... (cd-title cd) ... (cd-price cd) ...))


(define-struct sweater [material size color])
; A Sweater is (make-sweater String Size Color)
; interpretation:
;    An instance of a sweater, with it's
;    material size (type) and color (type)

; A Size is one of:
; - "small"
; - "medium"
; - "large"

; A Color is one of:
; - "black"
; - "white"
; - "blue"