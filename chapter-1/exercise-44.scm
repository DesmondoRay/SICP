;;; exercise 1.44

(load "exercise-43.scm")

(define (smooth f)
  (define dx 0.00001)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (smooth-times n f)
  ((repeated smooth n) f))

;; test
(display ((smooth square) 5))
(newline)
(display ((smooth-times 10 square) 5))

#| output:
25.000000000066663
25.000000000666663
|#