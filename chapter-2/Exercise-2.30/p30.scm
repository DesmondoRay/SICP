(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (square sub-tree)))
       tree))

;; test:
(newline)
(display 
 (square-tree-map
  (list 1
		(list 2 (list 3 4) 5)
		(list 6 7))))

;; output: (1 (4 (9 16) 25) (36 49))