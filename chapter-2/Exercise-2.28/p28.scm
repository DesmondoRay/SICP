(define (fringe x)
  (cond ((null? x)
         '())
        ((not (pair? x))
         (list x))
        (else (append (fringe (car x))
                      (fringe (cdr x))))))
          
(define x (list (list 1 2) (list 3 4)))

#| test: 
1 ]=> (fringe x)

;Value 13: (1 2 3 4)

1 ]=> (fringe (list x x))

;Value 14: (1 2 3 4 1 2 3 4)
|#