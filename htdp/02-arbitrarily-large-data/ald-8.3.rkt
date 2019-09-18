;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-8.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 8.3 Programming with Lists
;;;; ==========================
;;;; List primitives
;;;; @link: #(counter._(figure._fig~3acons))
;;;;
;;;; #: Check again the general design recipe
;;;;
;;;; #: Here we're starting to use recursive functions
;;;;    which works with the self-referential list definition
;;;;
;;;; #: We've recreated (member? ...) which checks a string for us
;;;;
;;;;    (member? "Flatt" ALOS)
;;;;
;;;;
;;;; #1: A slight mindfuck. Remember, you need a "break in the chain":
;;;;
;;;;     If the left side OR the right side of the list yield
;;;;     #true for (flatt? ...) return #true. Else return #false.
;;;;
;;;;     The list keeps moving outside->in until it hits '()
;;;;
;;;;     - Check if empty
;;;;     - If not empty, check if "Flatt" matches on left side
;;;;     - If not, pass through the function again
;;;;     - Keep checking if "Flatt" matches
;;;;     - Once you've checked the entire list, you're left with an empty list
;;;;     - which is empty, thus #false
;;;;
;;;;
;;;; #2: An alternative way to make the function work is to use
;;;;     another nested (cond ...) statement
;;;;
;;;;     - #1 seems a little
;;;;       more readable and simpler to understand in the Stepper


;;; Sample problem
;;; ==============
;;; A list of contacts (name, number)
;;; Owner can update
;;; Search name for "Flatt"

; Name is a String

; A List of Names is one of:
; - '()
; - (cons Name ALON)
; interpretation a list of names


; List-of-name -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (flatt? (first alon))
         (contains-flatt? (rest alon)))])) ; #! #1

; String -> Boolean
; checks if the string matches our name
(define (flatt? s)
  (string=? s "Flatt"))

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt?
               (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)
(check-expect (contains-flatt?
               (cons "A" (cons "Flat" (cons "Nope" '()))))
              #false)
(check-expect (contains-flatt?
               (cons "A" (cons "Flat" (cons "Flatt" '()))))
              #true)

; template --
; (define (contains-flatt? a-list-of-names)
;  #false)




;;; Exercise 132
;;; ============

(define a-long-list
  (cons "Fagan"
        (cons "Findler"
              (cons "Fisler"
                    (cons "Flanagan"
                          (cons "Flatt"
                                (cons "Felleisen"
                                      (cons "Friedman" '()))))))))

(contains-flatt? a-long-list) ; #true




;;; Exercise 133
;;; ============


; #2
;
; ... (cond
;       [(string=? (first alon) "Flatt") #true]
;       [else (contains-flatt? (rest alon))]) ...




;;; Exercise 134
;;; ============
;;; Develop the contains? function
;;; takes a string and checks if occurs on a given list of strings


; A List of Strings is one of:
; - '()
; - (cons Name ALOS)

(define ALOS1 (cons "Hannah"
                    (cons "Bob" '())))
(define ALOS2 (cons "Albert"
                    (cons "Rupert"
                          (cons "Hannah" '()))))
(define ALOS3 (cons "Louise"
                    (cons "Rebecca"
                          (cons "Albert"
                                (cons "Rupert" '())))))

; ALOS -> Boolean
; Checks a Name against a list of Names
(define (contains? l s)
  (cond
    [(empty? l) #false]
    [(cons? l)
     (or (string=? (first l) s)
         (contains? (rest l) s))]))  ; #!

(check-expect (contains? ALOS1 "Hannah") #true)
(check-expect (contains? ALOS2 "Louise") #false)
(check-expect (contains? ALOS3 "Rupert") #true)