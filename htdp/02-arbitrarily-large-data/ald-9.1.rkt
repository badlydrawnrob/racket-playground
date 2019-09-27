;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-9.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.1 Finger Exercises: Lists
;;;; ===========================
;;;;
;;;; ##: REVISIT input errors (6.3 Input Errors)
;;;;     and validating a list before passing it to a "proper"
;;;;     function (ex. 139 below)
;;;;
;;;; ##: Pay attention to base case (empty list) and booleans
;;;;
;;;;     - see #4 and #5
;;;;     - for now, we set '() to #true even if the function is
;;;;       looking for a specific value (i.e boolean value)
;;;;
;;;;
;;;; #1: You could add a (positive? ...) check here,
;;;;     but you'd need to add an error and possibly a nested
;;;;     condition ...
;;;;
;;;; #2: This is one of A List of amounts as empty is one if it's
;;;;     sub-classes of allowed data types
;;;;
;;;;     - You'd use (and ...) here as ALL need to be #true
;;;;     - You could also use the (positive? ...) function
;;;;
;;;; #3: First we pass the entire list to the pos function,
;;;;     if #true, we can pass it forward to the original sum function.
;;;;     We're separated concerns by having:
;;;;
;;;;     1. A recursive sum function
;;;;     2. A recursive pos? function
;;;;     3. A helper function to check for errors, then pass list
;;;;        to the sum function
;;;;
;;;;     #: This works, but everytime the function runs it get's
;;;;        passed through the (pos? ...) function, inefficient
;;;;
;;;; #4: The value for '() seems to need to be #true, otherwise it returns
;;;;     the wrong values (it returns #false when empty, breaking function)
;;;;
;;;; #5: You'd actually think this base case would confuse the function by
;;;;     always returning #true (as eventually the list is empty) but it
;;;;     doesn't seem to.


;;; Exercise 137
;;; ------------
;;; compare two templates
;;;
;;; The basic templates are the same:
;;;
;;; - both have two conditions
;;; - a base case
;;; - and selectors
;;;
;;; The implementation is different, mainly the combining function:
;;;
;;; - one uses cons? One uses else
;;; - one uses OR, one uses +
;;; - one uses an auxiliary function
;;; - one doesn't use (first ...) as it's not needed


; A List of Names is one of:
; - '()
; - (cons Name ALON)
; interpretation a list of names

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (flatt? (first alon))
         (contains-flatt? (rest alon)))]))

; String -> Boolean
(define (flatt? s)
  (string=? s "Flatt"))


; A list of strings is one of
; - '()
; - (cons String List-of-strings)

; A list of strings -> Number
; For every string in a list, add one
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else
     (+ (how-many (rest alos)) 1)]))



;;; Exercise 138
;;; ------------

; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of-amounts)

(define LIST0 '())               ; empty list (first data-type)
(define LIST1 (cons 5 LIST0))    ; second data type, List-of-amounts
(define LIST2 (cons 2.50 LIST1)) ; second data type, List-of-amounts
(define LIST3 (cons 6.30 LIST2)) ; second data type, List-of-amounts

; List-of-amounts -> Number
; Takes ALOA and returns the sum of the list
(define (aloa-sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l)
             (aloa-sum (rest l)))]))  ; #1


; LIST0 -> 0
; LIST1 -> 5
; LIST2 -> 7.50
; LIST3 -> 13.80

(check-expect (aloa-sum LIST0) 0)
(check-expect (aloa-sum LIST1) 5)
(check-expect (aloa-sum LIST2) 7.50)
(check-expect (aloa-sum LIST3) 13.80)



;;; Exercise 139
;;; ------------
;;; Some elements may not be the correct Type of
;;; inputs, so design a function to check for errors
;;;
;;; - If #true `l` is an element of List-of-amounts

; A List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)

; ALON -> Boolean
; Takes a list of numbers and checks if all are positive
(define (pos? l)
  (cond
    [(empty? l) #true] ; #2
    [else (and (> (first l) 0) ; #2
               (pos? (rest l)))]))

(define ALON0 '())
(define ALON1 (cons 1 ALON0))
(define ALON2 (cons 2 ALON1))
(define ALON3 (cons 3 ALON2))
(define ALON4 (cons 3 (cons 2 (cons -2 ALON0))))

(check-expect (pos? ALON0) #t)
(check-expect (pos? ALON1) #t)
(check-expect (pos? ALON2) #t)
(check-expect (pos? ALON3) #t)
(check-expect (pos? ALON4) #f)
(check-expect (pos? (cons 5 '())) #t)
(check-expect (pos? (cons -1 '())) #f)


; ALON -> Number
; Consumes a list of numbers and gives the sum
; (if one of List-of-Amounts) otherwise returns an error
(define (checked-sum l)
  (cond
    [(pos? l) (aloa-sum l)]
    [else (error "invalid list, positive numbers only")])) ; #3

; #3 #!
;(define (checked-sum l)
;  (cond
;    [(empty? l) 0]
;    [(and (pos? l)
;          (cons? l)) (+ (first l)
;                        (checked-sum (rest l)))]
;    [else (error "invalid list, positive numbers only")]))

(check-error (checked-sum ALON4))
(check-expect (checked-sum ALON0) 0)
(check-expect (checked-sum ALON1) 1)
(check-expect (checked-sum ALON2) 3)
(check-expect (checked-sum ALON3) 6)




;;; Exercise 140
;;; ------------

; A list of bools is one of:
; - '()
; - (cons Boolean List-of-bools)

; List-of-bools -> Boolean
; Takes a list and checks if all values are #true
(define (all-true l)
  (cond
    [(empty? l) #true] ; #4 #!
    [else (and (equal? (first l) #true)
               (all-true (rest l)))]))

(define LOB0 '())
(define LOB1 (cons #true LOB0))
(define LOB2 (cons #true LOB1))
(define LOB3 (cons #true (cons #false '())))

(check-expect (all-true LOB0) #true)
(check-expect (all-true LOB1) #true)
(check-expect (all-true LOB2) #true)
(check-expect (all-true LOB3) #false)

; List-of-bools -> Boolean
; Takes a list and checks if they're of List-of-bools type
(define (alob? l)
  (cond
    [(empty? l) #true] ; #5
    [(cons? l) (and (boolean? (first l))
               (alob? (rest l)))]))

(define ALOB?0 '())
(define ALOB?1 (cons 1 '()))
(define ALOB?2 (cons #t (cons #f '())))
(define ALOB?3 (cons #t (cons #f (cons "this" '()))))
(define ALOB?4 (cons #t (cons #t (cons #t '()))))

(check-expect (alob? ALOB?0) #t)
(check-expect (alob? ALOB?1) #f)
(check-expect (alob? ALOB?2) #t)
(check-expect (alob? ALOB?3) #f)

; Any -> Boolean
; Check that each list item is a member of List-of-bools
; Then run the all-true function
(define (checked-all-true l)
  (cond
    [(alob? l) (all-true l)]
    [else
     (error "wrong type or not a list-of-bools type")]))

(check-expect (checked-all-true ALOB?0) #t) ; #!
(check-error (checked-all-true ALOB?1))
(check-error (checked-all-true ALOB?3))
(check-expect (checked-all-true ALOB?4) #t)