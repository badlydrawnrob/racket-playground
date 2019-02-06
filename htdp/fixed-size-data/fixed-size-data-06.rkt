;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fixed-size-data-06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 2.3 Composing Functions
;; -----------------------
;; function composition,
;; main function,
;; helper functions
;;
;; > Define one function per task
;; > Main function compiles/runs the tasks
;;
;; #1: Allows you to read/write files
;; #2: Thing of 'stdout as a String for now

(require 2htdp/batch-io)  ; #1


; Main function example
(define (letter fst lst signature-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing signature-name)))

; Helper function example
(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the " "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize"))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

; Now, run the function
(letter "Bobby" "Charlton" "Babs")

; Enter this into cli
; — Consider 'stdout as a String for now ...
; (write-file 'stdout (letter "Matt" "Fiss" "Fell"))  ; #2