;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.1 Programming with Conditionals
;; ---------------------------------
;;
;; `if` is best used if describing one-or-another case
;; `cond` is best used for multi-conditions
;;     + `else` for the exact opposite of all other conditions
;;     + if all conditions must be met, use an error!

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Example 1
;; - Cond is quite self-expressive
;; - Helps remind you that there's (more than one) situations
;;   (in your data definitions)

(define (next current-color)
  (cond
    [(string=? "red" current-color) "yellow"]
    [(string=? "yellow" current-color) "green"]
    [(string=? "green" current-color) "red"]
    [else (error "That is not a valid color")]))

(check-expect (next "red") "yellow")


;; Example 2
;; #1: if between 0 and 10
;; #2: It's better to use [else "gold"]
;;     + BUT, with a negative number this would
;;       give us the wrong result

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]  ; #1
    [(and (< 10 s) (<= s 20)) "silver"]
    [(<= 20 s) "gold"]))  ; #2