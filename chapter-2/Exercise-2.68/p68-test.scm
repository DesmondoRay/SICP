(load "p68.scm")

(define tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define message '(A D A B B C A))

#| output: 
1 ]=> (encode message tree)

;Value 13: (0 1 1 0 0 1 0 1 0 1 1 1 0)
|#