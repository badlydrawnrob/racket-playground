;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.9 Structure in the World
;; ==========================
;; You'll need to represent each piece of information
;; along with relevant fields passed to the Universe
;;
;; A piece of information, may include more pieces of information
;; (think about nested functions, types, structures)
;;
;; Use the function recipes (and extended ones),
;; pen & paper, to consider each problem and the potential
;; data representations (and potential syntax) to use!

(require 2htdp/image)
(require 2htdp/universe)




; Sample problem
; --------------
; UFO | TANK
;
; - move at constant speeds
; - only need (ufo y-coordinate) – moves vertically in straight line
; - and (tank x-coordinate) - moves horizontally in straight line

(define-struct space-game [ufo tank])
; A space-game is a structure
;   (make-space-game Number Number)
; interpretation:
;   ufo has y-coordinate which is a positive integer
;   tank has x-coordinate which is a positive integer

(define sg1 (make-space-game 10 15))

; SG -> Image
; Plots the space-game onto a canvas
(define (space-game-template sg)
  (... (space-game-ufo sg)
       (space-game-tank sg)))




; Sample problem (upgraded!)
; --------------------------
; A SpaceGame is a structure:
;   (make-space-game Posn Number)
; interpretation (make-space-game (make-pson ux uy) tx)
; describes a configuration where the UFO is
; at (ux, uy) and the tank's x-coordinate is tx

