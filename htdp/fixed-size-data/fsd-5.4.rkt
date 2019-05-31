;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.4 Defining Structure Types
;; ============================
;; #1: It can be useful to separate concerns with nested structs
;;     + Also helps to be DRY code

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

; Store a struct [ constructor ]

(define matrix (make-movie "The Matrix" "Joel Silver" 1999))

; Recall a field [ selectors ]

(define title (movie-title matrix))
(define producer (movie-producer matrix))
(define year (movie-year matrix))

(text (string-append title ", "
                     producer ", "
                     (number->string year))
      18 "black")

; Check for validity [ predicate ]

(movie? matrix)



;; Exercise 66
;; -----------
;; - Give sensible values and create one instance
;;   of each structure type definition

(make-person "Andrew Sales" "blonde" "blue" "255-010101")
(make-pet "Bubbles" 2)
(make-CD "David Bowie" "Black Star" 10.99)
(make-sweater "polyester" "small" "H&M")



; Sample problem
; --------------
; Bouncing balls structure
; - location [int] px from top
; - SPEED [constant] # pixels per clock tick
; - velocity [speed + direction]
;   + naming convention signifies movement to future reader
;
; positive # (ball moves up)
; negative # (ball moves down)

(define-struct ball [location velocity])
(make-ball 10 -3)



;; Exercise 67
;; -----------
;; Another way to define our bouncing ball

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 10 "down")



; Example
; -------
; Nesting structures (they're just values!)

; A 3D position, and velocity coordinates (where next?)
(define-struct vel [deltax deltay])
(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))



;; Exercise 68
;; -----------
;; Alternative to nesting structures:
;; - multiple properties
;;   + (aka: flat representation)

(define-struct ballf [x y deltax deltay])
(define ball2
  (make-ballf 30 40 -10 5))



; Example
; -------
; Another example of nesting structures — phone book
; - Multiple instances of individual contact details

(define-struct centry [name home office cell])  ; #1
(define-struct phone [area number])             ; #1

(define address-book
  (make-centry "Shriram Fisler"
             (make-phone 207 "363-2421")
             (make-phone 101 "112-9981")
             (make-phone 208 "112-9981")))

(centry? address-book)
(phone-number (centry-home address-book))       ; #1