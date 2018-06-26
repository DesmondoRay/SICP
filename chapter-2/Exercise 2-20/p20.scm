(define (same-parity . items)
  (cons (car items)
        (same-parity-with-first (car items) (cdr items))))

(define (same-parity-with-first x y)
  (cond ((null? y) '())
        ((even? (abs (- x (car y))))
         (cons (car y)
               (same-parity-with-first x (cdr y))))
        (else (same-parity-with-first x (cdr y)))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
