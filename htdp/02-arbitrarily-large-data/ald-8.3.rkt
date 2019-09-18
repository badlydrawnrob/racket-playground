;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ald-8.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 8.3 Programming with Lists
;;;; ==========================
;;;; List primitives
;;;; @link: #(counter._(figure._fig~3acons))
;;;;
;;;; #: Check again the general design recipe


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
    [(empty? alon) ...]
    [(cons? alon)
     (... (first alon) ... (rest alon) ...)]))

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt?
               (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)
(check-expect (contains-flatt?
               (cons "A" (cons "Flat" (cons "Nope" '()))))
              #false)

; template --
; (define (contains-flatt? a-list-of-names)
;  #false)

