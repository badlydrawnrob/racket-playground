;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname recursion-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; 2. Example recursion
;;;; ====================
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
;;;; # A string is actually a fixed-length array of characters!
;;;;
;;;;   @link: https://docs.racket-lang.org/reference/strings.html
;;;;   @link: https://bit.ly/2m3eS5i
;;;;   @link: https://realpython.com/python-strings/
;;;;
;;;; #1: You actually may not even need a list for this
;;;;     but I'm not sure how yet!
;;;;
;;;; #2: (string->list ...) creates a list of chars (e.g: #\s)
;;;;
;;;;     - Meaning, you have to convert (#2a) back into a string
;;;;     - You could probably also use (string-join ...) here too
;;;;     - Remember to read functions inside->out
;;;;
;;;;     (list "s" "t") is two 1Char strings (less explicit)
;;;;     - so entering this will fail


;;; Adding hyphens to a string
;;; --------------------------
;;; You need to convert a string to a list, check if a string
;;; is empty, and add a hyphen on each character.
;;; If there's only one char, no hyphen
;;; If the last of a series of chars, no hyphen


;;; Wish list
;;; ---------
;;; - string is empty?
;;; - only one char?
;;; - last char?
;;; - add hyphen to char
;;; - a recursive function
;;;   - convert to a list
;;;   - have a base condition to stop an infinite loop


; String -> String
; for this method you have to slowly remove one letter
; from the string as you pass the remainder back into the function
(define (string->hyphens str)
  (cond
    [(< (string-length str) 1) ""]
    [(= (string-length str) 1) str]
    [else ...])) ; #1


; A List of Chars -> String
; for this method you have to have the initial empty? and cons?
; conditions, with an extra if condition for the last (single) char.
(define (alos->hyphens ls)
  (cond
    [(empty? ls) ""]
    [(cons? ls)
     (if (= 1 (length ls))
         (string (first ls))
         (string-append (string (first ls)) "-"
                    (alos->hyphens (rest ls))))]))

(define EMPTY (string->list ""))        ; #2
(define S (string->list "s"))           ; #2
(define STRING (string->list "string")) ; #2
(define ERROR (list "s" "t" "r" "i"))   ; #2

(check-expect (alos->hyphens EMPTY) "")
(check-expect (alos->hyphens S) "s")
(check-expect (alos->hyphens STRING) "s-t-r-i-n-g")
(check-error (alos->hyphens ERROR))