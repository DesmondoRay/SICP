;;; exercise 5.21 b)

(load "../common/5.2.1-the-machine-model.scm")

(define count-leaves-iter-machine
  (make-machine
   '(tree count continue)
   (list (list 'null? null?) (list 'pair? pair?)
         (list '+ +) (list 'car car) (list 'cdr cdr))
   '(count-leaves
     (assign count (const 0))
     (assign continue (label iter-done))
     
     iter-loop
     (test (op null?) (reg tree))
     (branch (label null-tree))
     (test (op pair?) (reg tree))
     (branch (label pair-tree))
     (assign count (op +) (reg count) (const 1))
     (goto (reg continue))
     
     pair-tree
     (save continue) 
     (save tree)
     (assign tree (op car) (reg tree))
     (assign continue (label after-pair-tree-1))
     (goto (label iter-loop))
     
     after-pair-tree-1
     (restore tree)
     (assign tree (op cdr) (reg tree))
     (assign continue (label after-pair-tree-2))
     (goto (label iter-loop))
     
     after-pair-tree-2
     (restore continue)
     (goto (reg continue))
     
     null-tree
     (goto (reg continue))
     
     iter-done)))


#|
1 ]=> (set-register-contents! count-leaves-iter-machine 'tree '((1 2) (3 (4 (5 6)))))

;Value: done

1 ]=> (start count-leaves-iter-machine)

;Value: done

1 ]=> (get-register-contents count-leaves-iter-machine 'count)

;Value: 6
|#
