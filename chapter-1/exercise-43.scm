;;; exercise 1.43

(load "exercise-42.scm")

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

((repeated square 2) 5)