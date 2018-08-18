(define (equal? a b)
  (cond ((not (pair? a))
         (eq? a b))
        ((not (eq? (car a) (car b)))
         false)
        (else (equal? (cdr a) (cdr b)))))

#| test:
1 ]=> (equal? '(this is a list ) '(this is a list))

;Value: #t

1 ]=> (equal? '(this (is a) list ) '(this is a list))

;Value: #f
|#