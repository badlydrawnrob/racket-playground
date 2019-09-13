;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-5.10.2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 5.10 A Graphical Editor (v02)
;; =============================
;;
;; != DESIGN DECISIONS MATTER (especially deeper into the code)
;;    - Originally we used a `pre` and `post` string,
;;      with the cursor inbetween.
;;    - Here, we're using a String and a Number. Cursor position
;;      is Number of chars from left
;;
;; != You're always passing an Editor structure around
;;    - the KeyEvent is an Editor structure
;;    - the function `render` will create the image
;;
;; != See: https://bit.ly/2XLxgRz for a refresher on difference
;;         between `cond` and `if` (latter for ONLY two possiblities)
;;
;; != How often should you check for (something? ...) and where/when?
;;
;; #1: substring should give the correct result
;; #2: now, you can just increase/decrease the number!
;;     - you could also use `add1` function
;; #3: you could always check (zero? editor-num ed) here
;; #4: Check for errors globally
(require 2htdp/image)
(require 2htdp/universe)


;; Exercise 87
;; ===========
;; A single line text editor
;; - count number of chars from cursor

(define-struct editor [str num])
; An Editor is a structure:
;    (make-editor String Number)
; interpretation (make-editor s n) describes an editor
; whose visible text is (editor-str s) and cursor at index n

(define line1 (make-editor "thisthat" 4))  ; cursor at middle
(define line2 (make-editor "this that" 5)) ; cursor at second "t"
(define line3 (make-editor "this that" 9)) ; cursor at end
(define line4 (make-editor "this that" 0)) ; cursor at start


;; Graphical constants
;; -------------------
;; add these in, not a bad idea

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

(define BUFFER-LENGTH 200) ; length of display
(define BUFFER-HEIGHT 20)  ; height of display

(define MT (empty-scene BUFFER-LENGTH BUFFER-HEIGHT))

(define CURSOR (rectangle 1 BUFFER-HEIGHT "solid" "red"))


; Editor -> String
; consume editor, output string
(define (string->text s)
  (text s TEXT-SIZE TEXT-COLOR))

; Editor -> String
; split to the left of the cursor
(define (editor->left ed)
  (substring (editor-str ed) 0 (editor-num ed)))  ; !=

; Editor -> String
; split to the right of the cursor
(define (editor->right ed)
  (substring (editor-str ed) (editor-num ed)))


; Editor -> Image
; consumes editor and outputs a string image
(define (render ed)
  (overlay/align "left" "center"
                 (beside (string->text (editor->left ed))  ; #1
                         CURSOR
                         (string->text (editor->right ed)))   ; #1
                 MT))

(check-expect (render line1) (overlay/align "left" "center"
                                            (beside (text "this" TEXT-SIZE TEXT-COLOR)
                                                    CURSOR
                                                    (text "that" TEXT-SIZE TEXT-COLOR))
                                            MT))



; Editor -> Editor
; allows the user to change text with keyevent
(define (edit ed ke)
  (cond
    [(key=? "left" ke) (move-left ed)]
    [(key=? "right" ke) (move-right ed)]
    [(key=? "\b" ke) (del-char ed)] ; delete char to left of cursor (if any)
    [(or (key=? "\t" ke) (key=? "\r" ke)) ed] ; ignore tab or return
    [(too-full? ed) ed] ; too many characters added?
    [(= (string-length ke) 1) (add-char ed ke)] ; add any single char
    [else ed])) ; ignore other KeyEvents






; String -> Boolean?
; check if a string is empty
(define (something? string)
  (> (string-length string) 0))

(check-expect (something? "t") #true)  ; #1
(check-expect (something? "") #false)


; Editor -> Editor
; moves the editor left (if "left" ke selected)
; and has characters to the left
(define (move-left ed)
  (if (something? (editor->left ed))
      (make-editor (editor-str ed) (- (editor-num ed) 1))  ; #2
      ed))  

(check-expect (move-left line1) (make-editor "thisthat" 3))
(check-expect (move-left line4) (make-editor "this that" 0))


; Editor -> Editor
; moves the editor right (if "right" ke selected)
; and if has characters to the right
(define (move-right ed)
  (if (something? (editor->right ed))
      (make-editor (editor-str ed) (+ (editor-num ed) 1))  ; #2
      ed))

(check-expect (move-right line1) (make-editor "thisthat" 5))
(check-expect (move-right line3) (make-editor "this that" 9))


; Editor -> Editor
; adds a character
(define (add-char ed char)
  (make-editor (string-append (editor->left ed) char (editor->right ed))
               (+ (editor-num ed) 1)))

(check-expect (add-char line1 " ") (make-editor "this that" 5))



; Editor -> String
; delete one to the left
(define (editor->del ed)
  (substring (editor-str ed) 0 (- (editor-num ed) 1)))

; Editor -> Editor
; deletes a character
(define (del-char ed)
  (if (something? (editor->left ed))  ; #3
      (make-editor (string-append (editor->del ed) (editor->right ed))
                   (- (editor-num ed) 1))
      ed))

(check-expect (del-char line1) (make-editor "thithat" 3))
(check-expect (del-char line4) (make-editor "this that" 0))


; Editor -> Boolean?
; check if too many characters to fit on screen
(define (too-full? ed)
  (>= (string-length (editor-str ed)) 40))

(define line5 (make-editor "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"  40))
(define line7 (make-editor "123456" 6))

(check-expect (too-full? line5) #true)
(check-expect (too-full? line7) #false)




;;; Exercise 114 — Checking for errors
;;; ----------------------------------

; Any Any -> Boolean
(define (string-and-num? a b)
  (and (string? a)
       (number? b)))

; Any -> Boolean
(define (check-editor? ed)
  (and (editor? ed)
       (string-and-num? (editor-str ed)
                        (editor-num ed))))

(define ED1 (make-editor "this" "that"))
(define ED2 (make-editor "this" 1))
(define ED3 (make-editor 1 "this"))
(define ED4 (make-editor #false 1))

(check-expect (check-editor? ED1) #false)
(check-expect (check-editor? ED2) #true)
(check-expect (check-editor? ED3) #false)
(check-expect (check-editor? ED4) #false)



;;; Run the program
;;; ---------------

(define (run ed)
  (big-bang ed
    [check-with check-editor?]  ; #4
    [to-draw render]
    [on-key edit]))