;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fsd-4.7.5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 4.7 Finite State Worlds
;; =======================
;; See 'state transition diagram'
;; — @link: https://bit.ly/2JoUyoJ
;;
;; See also Elm Lang state: https://bit.ly/2DWCdMq

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
