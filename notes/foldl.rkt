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