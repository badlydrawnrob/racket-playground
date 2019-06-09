;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.7.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;;
;; #1: You'd have to loop through colors variable (not possible in BSL)
;;

(require 2htdp/universe)
(require 2htdp/image)


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

; Make a color conditional:
; (check-expect (is-color? tshirt1) #true)
; (check-expect (is-color? tshirt2) #false)

(define colors
  (list "white"
        "yellow"
        "orange"
        "green"
        "red"
        "blue"
        "black"))
        
(define (is-color? c)
  (cond
    [(and (string? c) ...) #true]  ; #1
    [else #false]))

(define ORANGE "orange")
(define RED "red")
(define YELLOW "yellow")


; H is a Number between 0 and 100
; interpretation represents a happiness value

(define HAPPY 100)
(define OK 50)
(define SAD 0)


(define-struct person fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

(define HENRY (make-person "Henry" "Sandwich" #true))
(define MARIA (make-person "Maria" "Ashley" #false))

; I'm not sure. It's fairly obvious it's just a naming convention
; and is a pretty good indication that it's a Boolean
; as PREDICATES USE BOOLEANS .. seems ok.

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interpretation:
;   Owner is the dog's owner
;   Name is the first name of the dog
;   Age is a positive integer
;   H is how happy the dog is

(make-dog HENRY "Motley" 12 HAPPY)

; A Weapon is one of:
; - #false
; - Posn
; interpretation:
;   #false means the missile hasn't been fired yet;
;   a Posn means it is in flight

(define MISSILE #false)
(define FLYING-MISSILE (make-posn 34 12))

