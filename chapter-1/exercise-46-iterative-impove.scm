;;; exercise-46-iterative-impove.scm

(define (iterative-impove good-enough impove)
  (lambda (x)
    (if (good-enough x)
        x
        ((iterative-impove good-enough impove) (impove x)))))

