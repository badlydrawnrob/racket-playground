;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.3 Defining Structure Types
;; ============================

(require 2htdp/universe)
(require 2htdp/image)


;; Exercise 65
;; -----------
;; struct is a bit like a class:
;; - name (auto prefixed with `make-`)
;; - fields (recall with `structname-fieldname`)
;; - boolean (structname? returns #t or #f)

; Define a struct:
(define-struct movie [title producer year])
(define-struct person [name hair eyes phone])
(define-struct pet [name number])
(define-struct CD [artist title price])
(define-struct sweater [material size producer])

; Store a struct:
; - constructor

(define matrix (make-movie "The Matrix" "Joel Silver" 1999))

; Recall a field:
; - selectors

(define title (movie-title matrix))
(define producer (movie-producer matrix))
(define year (movie-year matrix))

(text (string-append title ", "
                     producer ", "
                     (number->string year))
      18 "black")

; Check for validity:
; - predicate

(movie? matrix)



;; Exercise 66
;; -----------
;; - Give sensible values and create one instance
;;   of each structure type definition

(make-person "Andrew Sales" "blonde" "blue" "255-010101")
(make-pet "Bubbles" 2)
(make-CD "David Bowie" "Black Star" 10.99)
(make-sweater "polyester" "small" "H&M")