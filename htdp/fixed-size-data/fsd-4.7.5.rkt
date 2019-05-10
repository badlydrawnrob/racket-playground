;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.7.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.7 Finite State Worlds
;; =======================
;; See 'state transition diagram'
;; — @link: https://bit.ly/2VYe8ih
;;
;; See also Elm Lang state: https://bit.ly/2DWCdMq
;;
;; #1: It's better to use constants and use these for
;;     our data definitions
;; #2: We use two conditions, together with (and ...)
;;     one for the DoorState, one for KeyEvent

(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


;; Sample problem
;; ==============
;; Simulate working of a door with an automatic door closer:
;;
;; 1. If locked -> Unlock with key
;; 2. If unlocked (door is closed) -> Push door to open
;; 3. Once walked through -> Door automatically closes
;; 4. Once closed -> Can be locked again


;;;; Start with translation of the world states


;; A DoorState is one of:
;; ----------------------
;; - LOCKED
;; - CLOSED
;; - OPEN

(define LOCKED "locked")  ; #1
(define CLOSED "closed")
(define OPEN "open")

;; A KeyEvent can be one of
;; ------------------------
;; - UNLOCK
;; - LOCK
;; - WALK (open the door)
(define UNLOCK "u")
(define LOCK "l")
(define WALK " ")


;;;; Now our action states ...


; DoorState -> DoorState
; ----------------------
; LOCKED -> LOCKED
; CLOSED -> CLOSED
; OPEN -> CLOSED
; ----------------------
; Atomatically close during one tick
; interpretation if open, close automatically

(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))


; DoorState KeyEvent -> DoorState
; -------------------------------
; LOCKED  +  "u"  ->  CLOSED
; CLOSED  +  "l"  ->  LOCKED
; CLOSED  +  " "  ->  OPEN
; OPEN    +  ___  ->  OPEN
; -------------------------------
; Turns key event k into an action on state s
; interpretation allows user to open, lock, or walk through

(check-expect (door-action LOCKED UNLOCK) CLOSED)
(check-expect (door-action CLOSED LOCK) LOCKED)
(check-expect (door-action CLOSED WALK) OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(define (door-action state-of-door key-event)
  (cond
    [(and (string=? LOCKED state-of-door)  ; #2
          (string=? UNLOCK key-event))
     CLOSED]
    [(and (string=? CLOSED state-of-door)
          (string=? LOCK key-event))
     LOCKED]
    [(and (string=? CLOSED state-of-door)
          (string=? WALK key-event))
     OPEN]
    [else state-of-door]))


; DoorState -> Image
; Show the current state of the door
(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))
(define (door-render state-of-door)
  (text state-of-door 40 "red"))


;;;; Finally, let's build our world ...


; DoorState -> DoorState
; Create the world and our interactive door
(define (main initial-state)
  (big-bang initial-state
    [to-draw door-render]
    [on-key door-action]
    [on-tick door-closer 1]))