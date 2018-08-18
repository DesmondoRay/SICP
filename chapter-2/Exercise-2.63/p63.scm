(load "../common/set-tree.scm")

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;; test
(define l (make-tree 2 '(1 () ()) '(3 () ())))
(define r (make-tree 6 '(5 () ()) '(7 () ())))
(define t (make-tree 4 l r))

#| output: 
1 ]=> (tree->list-1 t)

;Value 13: (1 2 3 4 5 6 7)

1 ]=> (tree->list-2 t)

;Value 14: (1 2 3 4 5 6 7)
|#