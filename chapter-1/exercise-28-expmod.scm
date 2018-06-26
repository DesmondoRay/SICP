;;; exercise 1.28

(define (square a) (* a a))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((nontrivial-square-root base m)
         0)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


(define (nontrivial-square-root a n)
  (and (not (= a 1))
       (not (= a (- n 1)))
       (= 1 (remainder(square a) n))))
