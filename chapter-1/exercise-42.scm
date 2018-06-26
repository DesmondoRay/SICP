;;; exercise 1.42

(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x) (* x x))

((compose square 1+) 6)