(load "p69.scm")

(define pairs (list (list 'a 4) (list 'b 2) (list 'c 1) (list 'd 1)))

#| output: 
1 ]=> (generate-buffman-tree pairs)

;Value 13: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
|#