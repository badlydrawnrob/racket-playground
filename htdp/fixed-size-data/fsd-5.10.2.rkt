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
;; #1: substring should give the correct result
;; #2: now, you can just increase/decrease the number!

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
; whose visible text is (editor-str s)

(define line1 (make-editor "thisthat" 4))  ; cursor at middle
(define line2 (make-editor "this that" 5)) ; cursor at second "t"
(define line3 (make-editor "this that" 9)) ; cursor at end
(define line4 (make-editor "this that" 0)) ; cursor at start


; Editor -> String
; consume editor, output string
(define (string->text s)
  (text s 11 "black"))

; Editor -> String
; split to the left of the cursor
(define (editor->left ed)
  (substring (editor-str ed) 0 (editor-num ed)))

; Editor -> String
; split to the right of the cursor
(define (editor->right ed)
  (substring (editor-str ed) (editor-num ed)))


; Editor -> Image
; consumes editor and outputs a string image
(define (render ed)
  (overlay/align "left" "center"
                 (beside (string->text (editor->left ed))  ; #1
                         (rectangle 1 20 "solid" "red")
                         (string->text (editor->right ed)))   ; #1
                 (empty-scene 200 20)))

(check-expect (render line1) (overlay/align "left" "center"
                                            (beside (text "this" 11 "black")
                                                    (rectangle 1 20 "solid" "red")
                                                    (text "that" 11 "black"))
                                            (empty-scene 200 20)))



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
  (if (something? (editor->left ed))
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




(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))