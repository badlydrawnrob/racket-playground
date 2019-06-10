;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.8.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; #1: There's NO COMPARISON OF STRING LENGTH here when
;;     adding a struct. It should only be 1String but a
;;     regular string works just the same.
;; #2: There's quite a lot of repetition here,
;;     remember the NESTED FUNCTION rule ...
;;     - split out functions
;;     - for one unit of work
;; #3: The function has been split as it's used repeatedly
;; #4: Using the predicate:
;;     - (if (not #true) "this" "that")  --> "that"
;;     - (if (not #false) "this" "that") --> "this"
;;
;;    != I'm unsure if having multiple output values is
;;       a good idea ... -> (union #false 1String)
;;
;;       You could also split this out into:
;;         1String 1String -> Boolean?
;;       and do the (not ...) check in the main function!
;;
;;    != You could either use (merge-letters ...)
;;       or just use (words->word ...) — I'm not sure which
;;       is more wasteful!!


(require 2htdp/universe)
(require 2htdp/image)



;; Exercise 81
;; ===========

(define-struct time [hours minutes seconds])
; Time is (make-time Number Number Number)
; interpretation:
;    The time that's passed since midnight
;    hours, minutes, seconds (with 2 integers each)

; Time -> Number
; outputs number of seconds that have passed since midnight
(define (time->seconds t)
  (+ (minutes->seconds (hours->minutes (time-hours t)))
     (minutes->seconds (time-minutes t))
     (time-seconds t)))

(define (minutes->seconds m)
  (* m 60))

(define (hours->minutes h)
  (* h 60))

(check-expect (time->seconds (make-time 1 1 0)) 3660)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds (make-time 5 29 13)) 19753)




;; Exercise 82
;; ===========
;; Compare two three-letter words (and their letters)

(define-struct word [let1 let2 let3])  ; #1
; A Word is a structure:
;   (make-word 1String 1String 1String)
; interpretation:
;   An instance of a word with three 1String letters
(define word1 (make-word "c" "a" "t"))
(define word2 (make-word "b" "a" "t"))
(define word3 (make-word "b" "o" "y"))

; Word Word -> Word
; compares two words and checks for equality
; - keep both words if they're the same
; - replace with new word if they don't match
;   + #false replacing different letters
(define (compare-word-template w1 w2)
  (... (... (word-let1 w1)
            (word-let2 w1)
            (word-let3 w1))  ; #2
       (... (word-let1 w2)   ; #2
            (word-let2 w2)
            (word-let3 w2))))

; So we need:
; 1. Compare the words as a whole
; 2. Compare the individual letters (if they don't match)
; 3. Rewrite the (compare-word ...) to output the desired results


;; 1. Compare the words as a whole
;; -------------------------------

; 1String 1String 1String -> String
; merges three 1String letters into a word
(define (merge-letters w)
  (string-append (word-let1 w)
                 (word-let2 w)
                 (word-let3 w)))

(check-expect (merge-letters word1) "cat")
(check-expect (merge-letters word2) "bat")

; Word Word -> Boolean?
; compares two words for equality
(define (word-equal? w1 w2)
  (if (string=? (merge-letters w1)
                (merge-letters w2)) #true #false))

(check-expect (word-equal? word1 word2) #false)
(check-expect (word-equal? word2 word2) #true)


;; 2. Compare the individual letters
;; ---------------------------------

; 1String 1String -> (union #false 1String)
; compares two 1String letters for equality
; #false if not, the original letter if #true
(define (letter l1 l2)
  (if (not (string=? l1 l2)) #false l1))  ; #4

(check-expect (letter "a" "b") #false)
(check-expect (letter "a" "a") "a")


; Word Word -> Word
; compares two (make-word ...) and checks for equality
; creates a new word, with #false if a letter doesn't match
(define (words->word w1 w2)
  (make-word (letter (word-let1 w1) (word-let1 w2))
             (letter (word-let2 w1) (word-let2 w2))
             (letter (word-let3 w1) (word-let3 w2))))

(check-expect (words->word word1 word2) (make-word #false "a" "t"))
(check-expect (words->word word1 word1) (make-word "c" "a" "t"))
(check-expect (words->word word1 word3) (make-word #false #false #false))


;; 3. Rewrite the original template function
;; -----------------------------------------

; Word Word -> Word
; 1. compares two words and checks for equality
; 2. keep both original words if they're the same
; 3. replace with new word if they don't match
;   + replace differing letters with #false

(define (compare-word w1 w2)
  (cond
    [(word-equal? w1 w2)
     (string-append (merge-letters w1) " is equal to " (merge-letters w2))]
    [else (words->word w1 w2)]))

; (compare-word word1 word2)
; (compare-word word2 word2)
; (compare-word word1 word3)