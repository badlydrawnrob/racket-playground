;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.5 Computing with Structures
;; =============================
;; It can be useful to separate concerns with nested structs
;; - Also helps to create DRY code
;; - And better represent the data examples/definitions

(define-struct entry [name number email])
(define pl (make-entry "Al Abe" "666-7771" "lee@x.me"))
(make-entry "Tara Harp" "666-7770" "th@smlu.edu")



;; Exercise 69
;; -----------
;; Drawing task
;;
;; (define-struct movie [title producer year])
;; (define matrix (make-movie "The Matrix" "Joel ..." 1999))
;;
;;  -------
;; | movie |
;; |---------------------------------|
;; | title        | producer  | year |
;; | ------------ | --------- | ---- |
;; | "The Matrix" | "Joel .." | 1999 |
;;  ---------------------------------
;;
;; > (movie-name matrix)
;; "The Matrix"




;; Exercise 70
;; -----------
;; DrRacket stores creates a pointer to each struct value

(define-struct centry [name home office cell])
; 1. (centry-name (make-centry n0 h0 o0 c0)) == n0
; 2. (centry-home (make-centry n0 h0 o0 c0)) == h0
; 3. (centry-office (make-centry n0 h0 o0 c0)) == o0
; ...
(define-struct phone [area number])
; 4. (phone-area (make-phone a0 n0)) == a0
; ...

(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981"))))
; Stepper:
; > Uses (3) to compare with struct and pull out `office` (o0)
; > Uses (4) to pull out `area` (a0) from value returned by `centry-office`
; > Returns 101




; Example: Predicates
; -------------------
; Compares value type against the struct
; - Returns #true if is of type
; - Returns #false if not of type

(define ap (make-posn 7 0))
(define pu (make-entry "Al Abe" "666-7771" "lee@x.me"))

(posn? ap)  ; #t
(posn? 42)  ; #f
(posn? pu)  ; #f

(entry? pu)    ; #t
(entry? #true) ; #f
(entry? ap)    ; #f



;; Exercise 71
;; -----------

(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH 400)
(define CENTER (quotient WIDTH 2))

(define-struct ball [location velocity])
(define-struct game [left-player right-player ball])

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

;; Stepper:
;; --------

(game-ball game0)
; > (game-ball game0)
; > (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
; ...
; ... (game [lp0 rp0 b0]) == b0
; ...
; > (game-ball (make-posn CENTER CENTER))
; > (game-ball (make-posn (quotient WIDTH 2)
;                         (quotient WIDTH 2)))
; ...
; ... (quotient WIDTH 2) == (/ WIDTH 2) == (/ 400 2)
; ...
; (make-posn 200 200)

(posn? (game-ball game0))
; > (posn? (make-posn 200 200))
; #true

(game-left-player game0)
; > (game-left-player game0))
; > (game-left-player (make-game MIDDLE MIDDLE (make-posn CENTER CENTER))
; ...
; ... (game [lp0 rp0 b0]) == lp0
; ...
; > (game-left-player MIDDLE)
; > (game-left-player (quotient HEIGHT 2))
; ...
; ... (quotient HEIGHT 2) == (/ HEIGHT 2)
; ...
; > (game-left-player (/ 200 2))
; 100