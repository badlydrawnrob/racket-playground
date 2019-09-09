;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-6.2.4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 6.2 Mixing up worlds
;;;; ====================
;;;;
;;;; !# THIS VERSION IS WRONG
;;;;    - It almost works but won't render for some reason
;;;;    — This method is more complex than it needs to be
;;;;      * See: 109_finite_sm.rkt in answers
;;;;
;;;; !# I'm sure this could be done better with string
;;;;    manipulation or a list, but using conditionals
;;;;
;;;; !# Not checking for error in input?
;;;;
;;;; !# The KeyEvent gets confusing for the "state machine"
;;;;
;;;; #1: Using abbreviated constants and definitions for
;;;;     our data definition
;;;;
;;;; #2: If it's not a string, quit the game

(require 2htdp/universe)
(require 2htdp/image)




;;; Exercise 109
;;; ------------
;;; See finite state machine: https://bit.ly/2lMblYX


;;; Types
;;; -----

;; ExpectsToSee is one of:
;; - AA
;; - BB
;; - DD
;; - ER

(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

;; Color is one of:
;; - EMPTY
;; - FIRST
;; - LAST
;; - ERROR

(define EMPTY "white")
(define FIRST "yellow")
(define LAST "green")
(define ERROR "red")


;; StringOrFalse is one of
;; - AA
;; - BB
;; - DD
;; - #false



;;; Constants
;;; ---------
(define WIDTH 100)
(define HEIGHT 100)
(define X (/ WIDTH 2))
(define Y (/ HEIGHT 2))
(define BACKGROUND (empty-scene WIDTH HEIGHT))




;;; Main structure
;;; --------------

(define-struct character [string])
; A Character is a structure
;   (make-struct StringOrFalse)
; StringOrFalse is current KeyEvent or #false

;(define (char-func char)
;  (... (character-string char))
;  (... (character-boolean char)))

(define CHAR0 (make-character ""))
(define CHAR1 (make-character "a"))    ; AA
(define CHAR2 (make-character "b"))    ; BB
(define CHAR3 (make-character "c"))    ; BB
(define CHAR4 (make-character "d"))    ; DD
(define CHAR5 (make-character #false)) ; ER


;;; Render states
;;; -------------

; Character -> Image
; Render the KeyEvent to an image
(define (render char)
  (cond
    [(equal? "" (character-string char))
     (shape (char->img (character-string char)) EMPTY)]
    [(equal? "a" (character-string char))
     (shape (char->img (character-string char)) FIRST)]
    [(equal? "d" (character-string char))
     (shape (char->img (character-string char)) LAST)]
    [(equal? #false (character-string char))
     (shape (char->img (boolean->string (character-string char))) ERROR)]))

(check-expect (render CHAR0) (shape (char->img "") EMPTY))
(check-expect (render CHAR1) (shape (char->img "a") FIRST))
(check-expect (render CHAR4) (shape (char->img "d") LAST))
(check-expect (render CHAR5) (shape (char->img "#false") ERROR))

; String -> Image
(define (char->img string)
  (text string 24 "black"))

; Image -> Image
(define (shape img color)
  (place-image (rectangle (image-width img)
                          (image-height img)
                          "solid"
                          color)
                X Y BACKGROUND))



;;; KeyEvent
;;; --------

(define (actions char ke)
  (cond
    [(and (key=? "a" ke)
          (not (middle? (character-string char)))
          (not (last? (character-string char))))
     (make-character "a")]
    [(and (key=? "b" ke)
          (or (first? (character-string char))
              (middle? (character-string char))))
     (make-character "b")]
    [(and (key=? "c" ke)
          (or (first? (character-string char))
              (middle? (character-string char))))
     (make-character "c")]
    [(and (key=? "d" ke)
          (not (string=? "" (character-string char)))
          (or (first? (character-string char))
              (middle? (character-string char))))
     (make-character "d")]
    [else (make-character #false)]))

(check-expect (actions CHAR0 "a") CHAR1)
(check-expect (actions CHAR1 "b") CHAR2)
(check-expect (actions CHAR2 "b") CHAR2)
(check-expect (actions CHAR2 "c") CHAR3)
(check-expect (actions CHAR3 "c") CHAR3)
(check-expect (actions CHAR3 "b") CHAR2)
(check-expect (actions CHAR0 "b") CHAR5)
(check-expect (actions CHAR0 "c") CHAR5)
(check-expect (actions CHAR0 "d") CHAR5)
(check-expect (actions CHAR1 "d") CHAR4)
(check-expect (actions CHAR2 "d") CHAR4)
(check-expect (actions CHAR3 "d") CHAR4)
 

; String -> Boolean?
(define (first? char)
  (string=? "a" char))

(check-expect (first? "a") #true)
(check-expect (first? "b") #false)

; String -> Boolean?
(define (middle? char)
  (or (string=? "b" char)
      (string=? "c" char)))

(check-expect (middle? "a") #false)
(check-expect (middle? "b") #true)
(check-expect (middle? "c") #true)
(check-expect (middle? "d") #false)

; String -> Boolean?
(define (last? char)
  (string=? "d" char))

(check-expect (last? "d") #true)
(check-expect (last? "a") #false)




;;; You fucked up
;;; -------------
;;; You're looking for TRUE when it's NOT a string :)

; Character -> Boolean?
(define (error? char)
  (not (string? (character-string char))))

(check-expect (error? CHAR0) #false)
(check-expect (error? CHAR1) #false)
(check-expect (error? CHAR5) #true)  ; #2




;;; Run the big 'en
;;; ---------------

(define (main char)
  (big-bang char
    [to-draw render]
    [on-key actions]
    [stop-when error render]))