;;; exercise 1.41

(define (double g)
  (lambda (x) (g(g x))))

(((double (double double)) 1+) 5)