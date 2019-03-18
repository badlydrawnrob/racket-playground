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



