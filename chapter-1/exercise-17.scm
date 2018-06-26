;;; exercise 1.17

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

(fast-mult 3 5)
(fast-mult 5 10)
(fast-mult 7 4038204830284023854023850242352)