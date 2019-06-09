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




(define-struct r3 [x y z])
;; An R3 is a structure:
;;    (make-r3 Number Number Number)
;; interpretation:
;;    Distance of objects in a
;;    3-dimensional space to origin
;;    using the x, y, z (depth?) coordinates
 
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


(check-within 13.19 (r3-distance-to-0 ex1) 13.20)  ; #2
(check-within 3.162 (r3-distance-to-0 ex2) 3.163)  ; #2

