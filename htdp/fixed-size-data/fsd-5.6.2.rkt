;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.6.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.6 Programming with Structures
;; ===============================
;;
;;   (define-struct posn [x y])
;;   ; A Posn is a structure:
;;   ;   (make-posn Number Number)
;;   ; interpretation a point x pixels from left, y from top
;;
;;
;; != When to use a setter or updater?
;;    - See 5.6.1