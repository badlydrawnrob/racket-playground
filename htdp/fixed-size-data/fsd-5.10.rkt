;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.10 A Graphical Editor
;; =======================
;;
;; != Should a new (make-editor ...) be made every time?
;; != Design decision is important
;;    - Here, we decide whether to add char to `-pre` or `-post`
;;
;; #1: It may be more efficient to use in (edit ...) cond?
;;     - Could also use (not (= 0 string1))

(require 2htdp/image)
(require 2htdp/universe)

;; Sample problem
;; --------------
;; A single line text editor
;; - chosen approach before
;; - alternative approach:
;;   - count chars to left of cursor position

(define-struct editor [pre post])
; An Editor is a structure:
;    (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t

(define line1 (make-editor "this" "that"))  ; 1st stage
(define line2 (make-editor "this " "that")) ; 2nd stage
(define line3 (make-editor "this that" ""))  ; 3rd stage



;; Exercise 83
;; ===========
;; I'm splitting out the functions as much as possible
;; seperation of concerns ...


; Editor -> String
; consume editor, output string
(define (editor->string func)
  (text func 11 "black"))

(check-expect (editor->string (editor-pre line1)) (text "this" 11 "black"))


; Editor -> Image
; consumes editor and outputs a string image
(define (render ed)
  (overlay/align "left" "center"
                 (beside (editor->string (editor-pre ed))
                         (rectangle 1 20 "solid" "red")
                         (editor->string (editor-post ed)))
                 (empty-scene 200 20)))

(check-expect (render line1) (overlay/align "left" "center"
                                            (beside (text "this" 11 "black")
                                                    (rectangle 1 20 "solid" "red")
                                                    (text "that" 11 "black"))
                                            (empty-scene 200 20)))



;; Exercise 84
;; ===========
;; Edits the editor

; Editor -> Editor
; allows the user to change text with keyevent
(define (edit ed ke)
  (cond
    [(key=? "left" ke) ...]
    [(key=? "right" ke) ...]
    [(= (string-length ke) 1) (add-char ed ke)]
    [(key=? "\b" ke) ...]
    [(or (key=? "\t" ke) (key=? "\r")) (render ed)]
    [else (render ed)]))



; add any single-character
; if "\b" delete character to left of cursor (if any)
; ignore "\t" key or "\r" key


; ignore other similar KeyEvents


;; Wish list
;; ---------

;; Auxiliary functions
;; -------------------

; String -> Boolean?
; check if a string is empty
(define (something? string)
  (> (string-length string) 0))

(check-expect (something? "t") #true)  ; #1
(check-expect (something? "") #false)

; String -> Char
; Get the first letter of a string
(define (string-first string)
  (string-ith string 0))

(check-expect (string-first "this") "t")


; String -> String
; Get the remainder of a string, removing first char
(define (string-rest string)
  (substring string 1))

(check-expect (string-rest "this") "his")


; Editor -> Editor
; moves the editor left (if "left" ke selected)
; and has characters to the left

; Editor -> Editor
; moves the editor right (if "right" ke selected)
; and if has characters to the right
(define (move-right ed)
  (if (something? (editor-post ed))
      (render (make-editor (string-append (editor-pre ed)
                                          (string-first (editor-post ed)))
                           (string-rest (editor-post ed))))
      (render ed)))  ; #2

(check-expect (move-right line1) (overlay/align "left" "center"
                                            (beside (text "thist" 11 "black")
                                                    (rectangle 1 20 "solid" "red")
                                                    (text "hat" 11 "black"))
                                            (empty-scene 200 20)))
(check-expect (move-right line3) (overlay/align "left" "center"
                                            (beside (text "this that" 11 "black")
                                                    (rectangle 1 20 "solid" "red")
                                                    (text "" 11 "black"))
                                            (empty-scene 200 20)))

              
; Editor -> Editor
; adds a character
(define (add-char ed char)
  (make-editor (string-append (editor-pre ed) char)
               (editor-post ed)))

(check-expect (add-char line1 " ") (make-editor "this " "that"))

; Editor -> Editor
; deletes a character
  

