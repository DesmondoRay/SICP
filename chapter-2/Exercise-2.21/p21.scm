(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list-2 items)
  (map (lambda (x) (* x x))
       items))

#| test:
1 ]=> (square-list (list 1 2 3 4))

;Value 13: (1 4 9 16)

1 ]=> (square-list-2 (list 2 3 4 5))

;Value 14: (4 9 16 25)
|#