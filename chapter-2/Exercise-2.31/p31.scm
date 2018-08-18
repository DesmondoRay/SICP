(define (square-tree tree)
  (tree-map square tree))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

;; test
(newline)
(display
 (square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7))))

;; output: (1 (4 (9 16) 25) (36 49))