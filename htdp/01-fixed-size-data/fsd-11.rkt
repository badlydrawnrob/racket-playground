;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 2.5 Programs
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


;; 1. data definitions (how you're representing information)
;; 2. function signature, statement of purpose, function header
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


;; Design the function, without worrying about it working
;; ======================================================
;; Make it work with any old output first


; Number String Image -> Image 
; adds s to img,
; y pixels from the top and 10 from the left
; given: 10 "this" img, expect: img (with string overlay)
(define (add-image y s img)
  (empty-scene 100 100))


;; Once you've designed your function, make it work!
;; =================================================
;; Code up the function properly, test it works

; Number -> Number
; computes the area of a square with side len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))


;; Another example:
;; ================
;; Create a dummy template with outline of functions

; Number String Image -> Image
; adds s to img,
; y pixels from the top and 10 from the left
; given:
;    5 for y,
;    "hello" for s, and
;    (empty-scene 100 100) for img
; expected:
;    (place-image (text "hello" 10 "red") 10 5 ...)
;    where ... is (empty-scene 100 100)
(define (add-another-image y s img)
  (place-image (text s 10 "red") 10 y img))
