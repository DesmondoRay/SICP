;;; exercise 1.42

(define (compose f g)
  (lambda (x) (f (g x))))


#| test:
1 ]=> ((compose square 1+) 6)

;Value: 49
|#