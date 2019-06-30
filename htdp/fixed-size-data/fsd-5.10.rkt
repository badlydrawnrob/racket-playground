;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.10 A Graphical Editor
;; =======================

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

(define line1 (make-editor "this" "that"))



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
    [(= (string-length ke) 1) ...]
    [(key=? "\b" ke) ...]
    [(or (key=? "\t" ke) (key=? "\r")) (render ed)]
    [else (render ed)]))



; add any single-character
; if "\b" delete character to left of cursor (if any)
; ignore "\t" key or "\r" key


; ignore other similar KeyEvents


;; Wish list
;; ---------

; Editor -> Editor
; moves the editor left (if "left" ke selected)
; and has characters to the left

; Editor -> Editor
; moves the editor right (if "right" ke selected)
; and if has characters to the right

; Editor -> Editor
; adds a character

; Editor -> Editor
; deletes a character
  


