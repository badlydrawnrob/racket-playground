;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname foldl) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Understanding the `foldl` function
;; — Reduce from the left
;;
;; f = function,
;; a = accumulator

(define (fold-left f a list)
  (cond
    [(empty? list) a]
    [else (fold-left f (f (first list) a)
                   (rest list))]))

(fold-left cons '() '(1 2 3))
(fold-left + 0 (list 1 2 3 4)) ; Easy to reason about
(fold-left - 0 (list 1 2 3 4)) ; Surprisingly, returns 2: https://stackoverflow.com/a/53563356


;; Stepping through '(1 2 3) ;;
;; ========================= ;;

;; Also see Elm versions:
;;   http://tinyurl.com/elm-lang-foldl-stepper
;;   http://tinyurl.com/elm-lang-foldl-debug-log

; (fold-left cons '() '(1 2 3))          -> f a list
;   (empty? '(1 2 3))                    -> #false
;   (cons (first '(1 2 3)) '())          -> f = cons
;   (fold-left '() '(1) (rest '(1 2 3))  -> '() '(1) '(2 3)
;
; (fold-left cons '(1) '(2 3))
; (fold-left cons '(2 1) '(3))
; (fold-left cons '(3 2 1) '())
;   (empty? '())                         -> #true
;
; '(3 2 1)