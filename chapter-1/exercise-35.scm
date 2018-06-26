;;; exercise 1.35

(load "exercise-35-fixed-point.scm")

(exact->inexact(fixed-point (lambda (x) (+ 1 (/ 1 x)))
                            1))