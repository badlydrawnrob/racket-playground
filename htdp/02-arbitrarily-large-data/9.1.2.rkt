;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.1.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 9.1 Finger Exercises: Lists
;;;; ===========================
;;;;
;;;; ##: Careful of base cases for '() empty lists!
;;;;
;;;;     - '() should be #false here. If any value is #true,
;;;;       (or ...) will ALWAYS return #true.
;;;;     - For (and ...) function, it's the reverse.
;;;;


;;; Exercise 140 (continued)

; A List of bools is one of:
; - '()
; - (cons Boolean List-of-bools)

; ALOB -> boolean
; Takes a list of boolean values and checks if they're all #true
(define (all-true l)
  (cond
    [(empty? l) #true]
    [else (and (first l)
               (all-true (rest l)))]))

(define ALOB0 '())
(define ALOB1 (cons #t '()))
(define ALOB2 (cons #t (cons #f '())))
(define ALOB3 (cons #t (cons #t (cons #t '()))))
(define ALOB4 (cons #f (cons #f (cons #t '()))))
(define ALOB5 (cons #f (cons #f (cons #f '()))))

(check-expect (all-true ALOB0) #t)
(check-expect (all-true ALOB1) #t)
(check-expect (all-true ALOB2) #f)
(check-expect (all-true ALOB3) #t)


; ALOB -> boolean
; Check if at least one List-of-bools is true
(define (one-true l)
  (cond
    [(empty? l) #false] ; #!
    [else (or (first l)
              (one-true (rest l)))]))

(check-expect (one-true ALOB0) #f) ; #!
(check-expect (one-true ALOB1) #t)
(check-expect (one-true ALOB2) #t)
(check-expect (one-true ALOB3) #t)
(check-expect (one-true ALOB4) #t)
(check-expect (one-true ALOB5) #f) ; #!

; '()                                          -> ??  #!
; (cons #f '())                                -> #f
; (cons #f (cons #t '()))                      -> #t    
; (cons #t (cons #t (cons #t '())))            -> #t
; (cons #f (cons #f (cons #f (cons #f '()))))  -> #f