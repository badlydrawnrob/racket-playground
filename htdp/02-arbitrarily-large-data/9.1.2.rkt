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
;;;; ##: Remember, you can think of the way a recursive function
;;;;     works in many ways:
;;;;
;;;;     - A tabular list (with progressive results)
;;;;     - Empty list -> full list (with each expected result)
;;;;
;;;; ##: Remember, it's easier to sketch out the whole function first!!!
;;;;     ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆

(require 2htdp/image)



;;; Exercise 140 (continued)
;;; ------------------------

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




;;; Exercise 141
;;; ------------
;;; Part of this definition is done for you ...

; List-of-string -> String
; concatenates all strings in l into one long string

(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect (cat (cons "ab"
                         (cons "cd"
                               (cons "ef" '())))) "abcdef")

(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l)
                         (cat (rest l)))]))


;; #!

; Tabular list of examples
;
; l            (first l) (rest l)      (cat (rest l)) (cat l)
; ----------------------------------------------------------
; (cons "a"    "a"       (cons         "b"            "ab"
;  (cons "b"              "b" '())
;   '()))
;
; (cons "ab"   "ab"       (cons "cd"   "cdef"         "abcdef"
;  (cons "cd"              (cons "ef"
;   (cons "ef"              '()))
;    '())))

; Empty -> Full list examples
;
; (cons '())     -> '()
;
; (cons "ab"     -> "ab"
;       '())
;
; (cons "ab"     -> "abcd"
;  (cons "cd"
;        '()))
;
; (cons "ab      -> "abcdef"
;  (cons "cd"
;   (cons "ef"
;         '())))