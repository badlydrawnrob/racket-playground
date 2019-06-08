;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.7 The Universe of Data
;; ========================
;;
;; != When to use a setter or updater?
;;    - See 5.6.1
;;
;; != ORDER MATTERS!
;;    - definitions should be in the correct order
;;
;; != (define-struct letter) may be the wrong way to do this,
;;    - might be better suited to a new TYPE
;;    - or, as a "virtual" type and a simple COND function
;;
;;
;; > If a function deals with nested structures,
;; > develop one function per level of nesting.
;;
;; > It's best to specify exactly what type of data,
;; > and which particular category of type is (and isn't) allowed
;; > in your data definitions!
;;
;; #1: COND is truthy (I think)
;;     - (equal? #false "a") returns #false
;;     - so moves to next line.
;;       - DOES NOT SEEM TO WORK the other way around!
;;
;; #2: This actually allows full strings ...
;;     - Don't yet know function to compare like (char? ...)
;;     - you'd have to add a (string-length ...) comparison
;;
;; #3: See below Exercise 78 for data examples
;;     you should provide for data definitions
;;     - @link: htdp.org/part_one.html#%28counter._data-uni._%28exercise._struct9%29%29

(require 2htdp/universe)
(require 2htdp/image)


; Sample image
; ------------
; @link: htdp.org/part_one.html#(counter._data-uni._(figure._fig~3auniverse))
; ------------
; The world of data definitions can be restricted within a
; function, program, or language; i.e:
;
; A BS is one of:
; - "hello",
; - "world", or
; - pi
;
; + any instance of Posn
;   - (make-posn 10 0)
;   - (make-posn (make-posn 0 1) 2)
;   - ...

(define-struct ball [location velocity])
; is now part of our world of data definitions

; Posn is (make-posn Number Number)
; - allows an infinite number of possible positions
;   - which can be nested inside a (make-ball ...)
;     - potentially nested inside some other function ...

; You can potentially construct these instances:
(make-posn (make-posn 1 1) "hello")
(make-posn (make-posn 2 1) 0)
; ... which make no sense but are allowed(!)


;; Exercise 76
;; ===========

; Movie is (make-movie String String Number)
; interpretation: title is the name of the film
;                 producer is the producer
;                 year is the release date
(define-struct movie [title producer year])

; Examples:
(define MOVIE1 (make-movie "Gone With the Wind" "John Ford" 1944))

; Extraction template:
(define (fn-for-movie m)
  (... (movie-title m)
       (movie-producer m)
       (movie-year m)))

; Person is (make-person String String String String)
; interpretation: name is the persons first/last name
;                 hair is the colour of their hair
;                 eyes is the colour of their eyes
;                 phone is their contact number
;                     (11 characters, no spaces)
(define-struct person [name hair eyes phone])

; Pet is (make-pet String Number)
; interpretation: name is the pets first name
;                 number is their identification
(define-struct pet [name number])

; CD is (make-cd String String Number)
; interpretation: artist is the creator of the music
;                 title is the CD name
;                 price is the cost of CD (in pounds)
(define-struct CD [artist title price])

; Sweater is (make-sweater String Number String)
; interpretation: material is the type of fabric
;                 size is one of ["small", "medium", "large"]
;                 producer is the company name
(define-struct sweater [material size producer])




;; Exercise 77
;; ===========
;; A point in time since midnight

; Since-Midnight is (make-since-midnight Number Number Number)
; interpretation: hours is number of hours since midnight
;                 minutes is number of minutes """
;                 seconds is number of seconds """
(define-struct since-midnight [hours minutes seconds])

(make-since-midnight 5 29 00)  ; 5:29hrs

(define (sample-function time)
  (... (since-midnight-hours time)
       (since-midnight-minutes time)
       (since-midnight-seconds time)))



;; Exercise 78
;; ===========
;; Represent 3-letter words (see exercise)

(define-struct word [let1 let2 let3])
; A Word is (make-word Letter Letter Letter)
; interpretation: A word consisting of three Letter types

(define w1 (make-word "c" "a" "t"))
(define w2 (make-word "d" "o" "g"))
(define w3 (make-word "b" #false "m"))

(define (func-for-word word)
  (... (word-let1 word)
       (word-let2 word)
       (word-let3 word)))


;; != Two routes for Letter:
;; -------------------------

(define-struct letter [l])
; A Letter is (make-letter [String, #false])
; interpretation: A Letter is one of:
;                 - "a" ... "z"
;                 - #false

;; ... or, a simple "virtual" Type
;; -------------------------------

; A Letter is one of:
; - 1String "a" ... "z"
; - #false


;; Either way, you'd need to add checks!
;; -------------------------------------
(check-expect (is-letter? "f") #true)
(check-expect (is-letter? "!") #false)
(check-expect (is-letter? #false) #true)
; (check-expect (is-letter? "too many chars") #false) ; #2

(define (is-letter? l)
  (cond [(equal? #false l) #true]  ; #1
        [(and (string? l) (string<=? "a" l "z")) #true]  ; #2
        [else #false]))




;; Exercise 79
;; ===========
;; Create examples for the following data definitions

; A Color is one of:
; - "white"
; - "yellow"
; - "orange"
; - "green"
; - "red"
; - "blue"
; - "black"

; Color is an enumeration
(define-struct tshirt [color size price])
; A Tshirt is (make-tshirt Color String Float)
(define tshirt1 (make-tshirt "white" "medium" 10.99))
(define tshirt2 (make-tshirt "turquoise" "medium" 10.99))

(define (is-color? tshirt1) #true)
(define (is-color? tshirt2) #false)


