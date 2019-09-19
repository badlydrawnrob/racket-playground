;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname recursion-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Example recursion
;;;; =================
;;;; The analogy of a ladder
;;;;
;;;; ╠═══╣ g
;;;; ╠═══╣ n
;;;; ╠═══╣ i
;;;; ╠═══╣ r
;;;; ╠═══╣ t
;;;; ╠═══╣ s
;;;;
;;;; #: I don't know yet how to convert the string
;;;;    to a list properly within the function, so make it
;;;;    easier by declaring a variable as a list.
;;;;
;;;; #: You actually may not even need a list for this


;;; Adding hyphens to a string
;;; --------------------------
;;; You need to convert a string to a list, check if a string
;;; is empty, and add a hyphen on each character, expect the first
;;; (if there's only one char) or the last of a series of chars


;;; Wish list
;;; ---------
;;; - string is empty?
;;; - only one char?
;;; - last char?
;;; - add hyphen to char
;;; - a recursive function
;;;   - convert to a list
;;;   - have a base condition to stop an infinite loop

(define EMPTY (string->list ""))
(define S (string->list "s"))
(define STRING (string->list "string"))


; String -> String
; Convert a string to a hyphenated string
(define (string->hyphens str)
  (cond
    [(empty? str) (string-append "" "")]
    [(= 1 (length str)) (string-append (list->string str))]
    [(> 1 (length str)) (string-append (list->string (first str)) "-")]
    [else (string->hyphens (rest str))]))

(check-expect (string->hyphens EMPTY) "")
(check-expect (string->hyphens S) "s")
(check-expect (string->hyphens STRING) "s-t-r-i-n-g")