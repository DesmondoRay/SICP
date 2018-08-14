;;; exercise 1.46 b

(load "exercise-46-iterative-impove.scm")

(define (average x y)
  (/ (+ x y) 2))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? guess)
    (< (abs (- guess (f guess))) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess)
          next
          (try next))))
  ((iterative-impove close-enough? try) first-guess))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

#| test:
1 ]=> (sqrt 2)

;Value: 1.4142135623746899
|#
