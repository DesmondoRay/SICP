;;; exercise 1.39

(define (tan-cf x k)
  (define (iter k result)
    (if (= k 1)
        (/ x (- 1 result))
        (iter (- k 1) (/ (square x) (- (- (* k 2) 1) result)))))
  (iter k 0))

(define (square x) (* x x))

(exact->inexact(tan-cf 1 10))
