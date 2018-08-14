;;; exercise 1.41

(define (double g)
  (lambda (x) (g (g x))))

#| test:
1 ]=> (((double (double double)) 1+) 5)

;Value: 21
|#