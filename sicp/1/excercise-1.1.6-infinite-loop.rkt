#lang sicp

(define (sqrt-iter-new-if guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter-new-if (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square n)
  (* n n))


;;; Exercise 1.6 =================================================================
;;
;; Alyssa P. Hacker doesn’t see why if needs to be provided as a special form.
;; “Why can’t I just define it as an ordinary procedure in terms of cond?”

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5) ; => 5
(new-if (= 2 2) 0 5) ; => 0


;; APPLICATIVE ORDER
;;
;; evaluates all the functions _before_ the cond statements can be resolved.
;; : Causes an infinite loop!
;;
;; IT'S ALSO QUITE CONFUSING TO READ AND REASON ABOUT!!!

(sqrt-iter-new-if 1 2) ; #! infinite loop!

(sqrt-iter-new-if (new-if (good-enough? 1 2) 1 (sqrt-iter-new-if (improve-guess 1 2) 2)))

(sqrt-iter (new-if (< (abs (- (square guess) x)) 0.001) 1 (sqrt-iter-new-if (average guess (/ x guess)) 2)))

(sqrt-iter (new-if (< (abs (- (* guess guess) x) 0.001) 1 (sqrt-iter-new-if ...))))

(sqrt-iter (new-if (< (abs (- (* 1 1) ..)))))

(sqrt-iter (new-if (< (abs (- 1 2) ...))))

(sqrt-iter (new-if (< (abs -1) ...)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if (average 1 (/ 2 1)) 2)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if (average 1 2) 2)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if (/ (+ x y) 2) 2)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if (/ (+ 1 2) 2) 2)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if (/ 3 2) 2)))

(sqrt-iter (new-if (< 1 0.001) 1 (sqrt-iter-new-if 1.5 2)))

;; => Just to make explicit: We're back to the start again

(sqrt-iter (new-if #t 1 (sqrt-iter-new-if guess x))) 

;; => Begin recursive function, pass through again to `new-if`

(sqrt-iter (new-if #t 1 (sqrt-iter-new-if
                          (new-if (good-enough? 1.5 2) 1.5
                                  (sqrt-iter-new-if (improve-guess 1.5 2) 2)))))

;; => This continues on, and on, because the conditional statement never resolves!!
