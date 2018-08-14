;;; exercise 1.40

(load "exercise-35-fixed-point.scm")
(load "exercise-40-newton-method.scm")

(define (cubic a b c)
  (lambda (x) (+ (cube x)
                 (* a (square x))
                 (* b x)
                 c)))

(define (cube x) (* x x x))


#| test:
1 ]=> (newton-method (cubic 1 1 1) 1.0)

;Value: -.9999999999997796

1 ]=> (newton-method (cubic 0 0 -8) 1.0)

;Value: 2.000000000036784
|#