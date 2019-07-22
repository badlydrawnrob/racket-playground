;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 3.2 Finger Exercises: Functions
;;
;; 1. What is the problem question?
;; 2. Chunk it into component parts (questions/output)
;; 3. Create one function per task
;; 4. Simplify! KISS, ACID, DRY, IO (no mutation)
;;
;; "For every constant mentioned in a problem statement,
;;  introduce one constant definition."
;;
;; On human error. Don't make me think!
;; "Write as if you're stupid, for your stupid future self"
;;
;; Two types of programs: Batch (i/o), interactive (gui)
;;
;; object (thing) -> data (representation of object) -> program (interpret data)
;; @ https://bit.ly/2ufB39f

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; big-bang: order matters!
;; @ https://bit.ly/2FbVzwA
;;
;; (define (main y)              expression -> Master function
;;  (big-bang y                  expression -> big-bang -> initial state
;;    [on-tick sub1]             Event handler -> transform state
;;    [stop-when zero?]          End program
;;    [to-draw render-function]  Event handler -> render state
;;    [on-key stop-function]))   Event handler -> end program


;; 1. Data definitions (how you're representing information)
;; 2. Function signature, statement of purpose, function header
;;    — inputs consumed, outputs produced
;;    - what does the function compute?
;;    - Give it a name, paramaters and dummy output (stub, definititon type)
;; 3. Illustrate the function with some examples
;; 4. Take inventory. What do we need to do to make it work?
;;    - Make a basic template 
;; 5. Build the function as described above
;; 6. Test the function works
;;    - errors: check examples are correct
;;              check for logical errors in function


;; Ex. 34

; String -> Char
; Extract first char from non-empty string
; given: "bertie", expected: "b"
(define (string-first string)
  (string-ith string 0))

;; Ex. 35

; String -> Char
; Extract last character from non-empty string
; given: "julie", expected: #\e
(define (string-last string)
  (string-ref string (- (string-length string) 1)))

;; Ex. 36

; Image -> Number
; Counts number of pixels in a given image
; given:
;    (circle 30 "outline" "red")
; expected:
;    3600
(define (image-area img)
  (* (image-height img) (image-width img)))

;; Ex. 37

; String -> String
; Produces a duplicate string with first character removed
; given: "scrumptious", expected: "crumptious"
; (define (string-rest string) "") — stub
(define (string-rest string)
  (substring string 1))

;; Ex. 28

; String -> String
; Produces duplicate string with last character removed
; given "bloody hell", expected: "bloody hel"
; (define (string-remove-last string) "")
(define (string-remove-last string)
  (substring string 0 (- (string-length string) 1)))
