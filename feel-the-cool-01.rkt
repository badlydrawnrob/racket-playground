#lang racket

; Feel the cool: https://youtu.be/tA1clbGDczI
;
; ⊡ mini-frame:
;
; 1. Skip over the stuff you know
; 2. Add interesting or "struggling with" ideas
; 3. Drill them
; 4. Learn backwards and forwards (interleave)

(require rackunit)

;; The basic syntax and lists
;; ==========================

(define (abs x)
        (if (< x 0) ; predicate
            (- x)   ; #true
            x))     ; #false


(define list1 (list 1 2 3)) ; prints as a symbol in racket? '(9 3 5)
(define list2 (sort (list 1 3 2) >)) ; returns ordered list, greater than
(length list1) ; return the length of list1





;; Scheme is weird
;; ===============
;; Get used to recursion
;; and passing functions around

(car list1) ; return 1st thing
(cdr list1) ; return rest of list

(cons "a" "b")      ; pair '("a" . "b")
(cons (cons 5 6) 7) ; pair, within a pair '((5 . 6) . 7)


; A list is just a pair
; ---------------------
; or a collection of pairs

(define pair (cons 1 2)) ; '(1 . 2)
(car pair) ; 1
(cdr pair) ; 2

(define pair-empty (cons 2 null)) ; 2 and () -> (2 . ()) -> (2)
(car pair-empty)       ; 2
(cdr pair-empty)       ; '()

(cons 1 (cons 2 null)) ; (1 2)
(list 1 2)             ; (1 2)

; So (car ...) pulls the left side of the first pair [head]
; and (cdr ...) pulls the right side of pair (and any nested pairs) [tail]





;; It get's weirder
;; ================
;; https://stackoverflow.com/a/13112481 (cadr explained)
;; https://stackoverflow.com/a/21492610 (testing with #lang)

; (cadddr v)
; (car (cdr (cdr (cdr v)))  1st, 2nd, 3rd, 4th item on the list
(cadddr (list 1 2 3 4)) ; what will this return?


; Recursive function
; ------------------
; 1. Pass a list to (sum ...)
; 2. Add the first number
; 3. Pass the rest of the list back into the function
; 4. Repeat until only one list item
; 5. Return the result

(define (sum vs) ; Add an 's' to operand, indicates i/o list (convention)
        (if (= 1 (length vs))
            (car vs)
            (+ (car vs)           ; left side (of 1st pair)
               (sum (cdr vs)))))  ; right side (nested pairs)

(check-eq? (sum (list 1 2 3 4)) 10)
(check-eq? (sum (list 1)) 1)


; Meta functions
; --------------
; Using a function as an argument
; — allows to use function on left side
; - to compute value on right side

; Number -> Number
(define (double value)
  (* 2 value))

(check-eq? (double 2) 4)
(check-eq? (double 0) 0)

; Function Number -> Number
; apply (double ...) to value, twice! 
(define (apply-twice fn value)
  (fn (fn value)))

(check-eq? (apply-twice double 2) 8)


; Mapping
; -------
; Map takes a function and a list
; — applies function to each list item
; — returns new list

; List -> List
(map double (list 3 4 5)) ; '(6 8 10)


; Code as data
; ------------
; Creates a quote: '(...)

(define s (list '+ 4 7)) ; '(+ 4 7)


; Evaluating data (as code)
; -------------------------
; Typing this into terminal evaluates the expression
; turning the list into a proper addition function
;
; > (eval s)




;; Allowing you to do some interesting stuff
;; =========================================
;; Converting some data into different data
;; - for example, a part of a quote

; List -> Symbol
; creates symbol of operator, and tail of list
(define (switchop a) (cons '* (cdr a))) ; '(1 2 3) -> '(* 2 3)
(define s2 (switchop s)) ; Converts '(+ 4 7) -> '(* 4 7)

; Now our original quote is changed
; ---------------------------------
; > (eval s2)