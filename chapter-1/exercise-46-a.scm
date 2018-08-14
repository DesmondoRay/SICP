;;; exercise 1.46 a

(load "exercise-46-iterative-impove.scm")

(define (average x y)
  (/ (+ x y) 2))

(define tolerance 0.00001)

(define (sqrt-iter guess x)
  (define (good-enough guess)
    (< (abs (- (square guess) x)) tolerance))
  (define (impove guess)
    (average guess (/ x guess)))

  ((iterative-impove good-enough impove) guess))


#| test:
1 ]=> (sqrt-iter 1.0 2)

;Value: 1.4142156862745097
|#