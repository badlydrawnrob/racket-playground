;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fixed-size-data-09) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; (write-file filename string)
;; - also accepts 'stdout (prints string to console)

;; (read-file string)
;; - also accepts 'stdin (instead of file name)

;; Celsius to farenheit:
;; - C = 5/9 * (f - 32)
;;   - f is a given value
;;   - C is computed from f
;;   - so C(f) is the function definition

(define (C f)
  (* 5/9 (- f 32)))

;; Read in farenheit
;; Write out celsius
;; - The function processes from the inside out!
;; - Seems to output a fraction (not a decimal string)

(define (convert in out)
  (write-file out
    (string-append
      (number->string
        (C
         (string->number
           (read-file in))))
      "\n")))
         