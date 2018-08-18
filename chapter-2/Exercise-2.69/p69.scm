(load "../common/huffman-leaf.scm")
(load "../common/buffman-tree.scm")
(load "../common/buffman-decode.scm")
(load "../common/buffman-set.scm")

(define (generate-buffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((= 0 (length leaf-set))
         '())
        ((= 1 (length leaf-set))
         (car leaf-set))
        (else (let ((sub-tree (make-code-tree (car leaf-set)
                                              (cadr leaf-set))))
                (successive-merge (adjoin-set sub-tree
                                              (cddr leaf-set)))))))