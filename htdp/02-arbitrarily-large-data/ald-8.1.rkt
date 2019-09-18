;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-8.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 8.1 Creating lists
;;;; ==================
;;;; Self-referential data definitions
;;;;
;;;; #! You can read a list from the outside->in
;;;;
;;;;    - it's constructed inside->out!
;;;;    - it's a special constructor (a bit like make-)
;;;;    — think of it like a russian doll
;;;;
;;;; #! Like a recurring function, a data definition can
;;;;    be self-referential. Meaning it can reference itself.
;;;;
;;;;    - we use it to make sure a cons chunk is of Type
;;;;
;;;; #1,
;;;; #2: Finite vs unlimited list data definitions
;;;;
;;;;

(require 2htdp/universe)
(require 2htdp/image)



;;; Demo
;;; ----
;;; Building lists

'() ; empty list

(cons "Mercury" '()) ; A pair (of list items)

(cons "Earth"
      (cons "Venus"
            (cons "Mercury"
                  '()))) ; An array (lots of list pairs)



;;; Exercise 129
;;; ============

; 1. A list of celestial bodies
(cons "Earth"
      (cons "Jupiter"
            (cons "Neptune"
                  (cons "Uranus"
                        (cons "Mars"
                              (cons "Saturn"
                                    (cons "Venus"
                                          (cons "Mecury"
                                                '()))))))))
; 2. can't be arsed
; 3. can't be arsed



;;; Mixed values
;;; ------------

(cons "Robbie Round"     ; employee name
      (cons 3            ; years at company
            (cons #true  ; has health insurance?
                  '()))) ; empty list


;;; A list data definition
;;; ----------------------
;;; #1: A finite number of list items
;;; #2: A number of list items (no set limit)
;;;     either nothing (empty) or x number of (cons String ...)

; A 3LON is a list of three numbers:
;   (cons Number (cons Number (cons Number '())))
; interpretation a point in 3-dimensional space

; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation a list of invitees, by last name

(cons "Findler" '())       ; examples
(cons "Felleisen" '())     ; of single entry
(cons "Krishnamurthi" '()) ; List-of-names


(cons "Felleisen" (cons "Findler" '())) ; Two List-of-names
; A String        A String        Empty



;;; Exercises 130
;;; =============

(cons "Dereck"
      (cons "Hannah"
            (cons "Betty"
                  (cons "James"
                        (cons "Robin"
                              '())))))  ; Multiple List-of-names

; Is a List-of-names
(cons "1" (cons "2" '())) ; contains numbers as String
; Not a List-of-names
(cons 2 '())              ; contains numbers (not a String)



;;; Exercise 131
;;; ============

; A List-of-bool is one of:
; - '()
; - (cons Boolean List-of-bool)

(cons #true
      (cons #false
            (cons #true
                  (cons #true
                        '()))))