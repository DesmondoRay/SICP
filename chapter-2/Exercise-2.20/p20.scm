(define (same-parity . items)
  (cons (car items)
        (same-parity-with-first (car items) (cdr items))))

(define (same-parity-with-first x y)
  (cond ((null? y) '())
        ((even? (abs (- x (car y))))
         (cons (car y)
               (same-parity-with-first x (cdr y))))
        (else (same-parity-with-first x (cdr y)))))


#| test:
1 ]=> (same-parity 1 2 3 4 5 6 7)

;Value 13: (1 3 5 7)

1 ]=> (same-parity 2 3 4 5 6 7)

;Value 14: (2 4 6)
|#