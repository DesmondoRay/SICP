(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        (reverse answer)
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

#| test: 
1 ]=> (square-list (list 1 2 3 4))

;Value 13: (1 4 9 16)
|#