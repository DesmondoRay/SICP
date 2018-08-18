(load "../common/huffman-leaf.scm")
(load "../common/buffman-tree.scm")
(load "../common/buffman-decode.scm")
(load "../common/buffman-set.scm")

(define pairs (list (list 'a 4) (list 'b 2) (list 'c 1)))

#| output:
1 ]=> (make-leaf-set pairs)

;Value 13: ((leaf c 1) (leaf b 2) (leaf a 4))
|#