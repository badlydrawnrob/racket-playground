;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; Two types of programs: Batch (i/o), interactive (gui)

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

;; Introduction to big-bang:
;; @ https://bit.ly/2FbVzwA
;; — initial state,
;; - transformed state (event handler),
;; - rendered state (new state, using function)
;;
;; ! Order matters, `big-bang` "runs" through conditions
;;   and passes each to the event-handler when required
;;   which in turn generates the new state

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))

(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))

(define (stop y ke)
  0)



