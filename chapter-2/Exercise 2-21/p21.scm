(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list-2 items)
  (map (lambda (x) (* x x))
       items))

(square-list (list 1 2 3 4))
(square-list-2 (list 2 3 4 5))
