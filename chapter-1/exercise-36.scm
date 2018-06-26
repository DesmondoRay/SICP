;;; exercise 1.36

(load "exercise-36-fixed-point.scm")

(exact->inexact(fixed-point (lambda (x) (/ (log 1000) (log x)))
                            2))

(exact->inexact(fixed-point (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2))
                            2))