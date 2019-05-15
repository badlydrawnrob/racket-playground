;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.3 Programming with posn
;; =========================
;; #1: Numbers are crazy:
;;     @link: https://bit.ly/2Q8jKkD
;;            https://bit.ly/2WKac1S
;; #2: Fails as function returns inexact number

(require 2htdp/universe)
(require 2htdp/image)

;; How might we design a function that computes the
;; distance from x,y to origin?
;; - @link: https://bit.ly/2VrhRAu

; Exponents:
; — There's no ** shorthand, so 3**3:
; - (expt 3 3) -or- (* 3 3 3)
; - (expt 2 2) -or- (sqr 2)

; Square root:
; - (floor (sqrt n))
;   + (integer-sqrt n)


;; My version, which accounts for fringe case
;; ------------------------------------------
;; You can't check-expect inexact numbers!
;; @link: https://bit.ly/2JlYJCw

(check-expect (distance-to-0 (make-posn 3 4)) 5)       ; #1
(check-expect (distance-to-0 (make-posn 8 6)) 10)      ; #1
(check-expect (distance-to-0 (make-posn 5 12)) 13)     ; #1
(check-expect (distance-to-0 (make-posn 10.6 12)) 16)  ; #1

(define (distance-to-0 posn)
  (inexact->exact
   (floor (sqrt (+ (expt (posn-x posn) 2)
                   (expt (posn-y posn) 2))))))



;; Original, simpler version
;; -------------------------

(check-expect (simple-distance-to-0 (make-posn 3 4)) 5)
(check-expect (simple-distance-to-0 (make-posn 8 6)) 10)
(check-expect (simple-distance-to-0 (make-posn 5 12)) 13)
(check-expect (simple-distance-to-0 (make-posn 10.6 12)) 16)  ; #2

(define (simple-distance-to-0 ap)
  (sqrt (+ (sqr (posn-x ap))
           (sqr (posn-y ap)))))
