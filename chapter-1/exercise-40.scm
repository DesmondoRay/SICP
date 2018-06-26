;;; exercise 1.40

(load "exercise-40-newton-method.scm")

(define (cubic a b c)
  (lambda (x) (+ (cube x)
                 (* a (square x))
                 (* b x)
                 c)))

(define (square x) (* x x))
(define (cube x) (* x x x))

(newton-method (cubic 1 1 1) 1.0)
(newton-method (cubic 0 0 -8) 1.0)