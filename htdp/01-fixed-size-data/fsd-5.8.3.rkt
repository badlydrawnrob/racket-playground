;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.8.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.8 Designing with Structures
;; =============================
;;
;; Read the update design recipe:
;; - @link: ./__README-02.md
;;
;; For types of data that are a whole "thing"
;; (i.e. an "object") USE A STRUCTURE
;; ------------------------------------------
;; - consume the structure with a function
;; - use design recipe to build the function
;;   - data consumed/output and function header
;;   - write down available data in a dummy template
;;     - (even if you don't need all of them)
;; - TEST that motherfucker
;;
;;
;; Revisited: fsd-5.8.2
;;            - Simplify functions for exercise 82
;;            - more complicated than the task needed
;;              (poor instructions though)
;;
;;
;; #1: A nested (cond ...) seems to be the best way here
;;     - You're checking both are a Letter type first
;;     - Then checking if they're equal
;;     - != is there a way to do this in ONE condition?


;; Exercise 82
;; ===========
;; Compare two words
;; - output word if matches
;; - or #false for any letters that don't match

; Wish list
; ---------
; 1. The 3 letter struct
;    + Letter data definition
; 2. The letter function
; 3. string? "a" to "z"
; 4. The comparison function


; A Letter is one of:
; - 1String ("a" to "z")
; - #false
(define-struct word [let1 let2 let3])
; A Word is a structure:
;   (make-word Letter Letter Letter)
; interpretation
;   a three-letter word made of Letters

(define word1 (make-word "c" "a" "t"))
(define word2 (make-word "c" "a" "r"))
(define word3 (make-word "b" "o" "y"))


; Letter Letter -> (union 1String #false)
; Compare two letters for equality
(define (letters->letter l1 l2)
  (cond [(and (1String? l1)
              (1String? l2))
         (cond [(equal? l1 l2) l1]
               [else #false])]  ; #1
        [else #false]))

(check-expect (letters->letter (word-let1 word1)
                               (word-let1 word1)) "c")
(check-expect (letters->letter (word-let1 word1)
                               (word-let1 word3)) #false)
(check-expect (letters->letter (word-let1 word1)
                               #false) #false)


; 1String -> Boolean?
; Checks if string is "a"->"z" or 1String
(define (1String? l)
  (and (string? l)
       (string<=? "a" l "z")
       (equal? 1 (string-length l))))

(check-expect (1String? "a") #true)
(check-expect (1String? "!") #false)
(check-expect (1String? "ca") #false)


; Word Word -> Word
; Compares two words for equality
; - Word matches, Some letters match, or no letters match
(define (words->word w1 w2)
  (make-word (letters->letter (word-let1 w1) (word-let1 w2))
             (letters->letter (word-let2 w1) (word-let2 w2))
             (letters->letter (word-let3 w1) (word-let3 w2))))

(check-expect (words->word word1 word1) word1)
(check-expect (words->word word1 word2) (make-word "c" "a" #false))
(check-expect (words->word word1 word3) (make-word #false #false #false))
