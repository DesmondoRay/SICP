;;; exercise 5.21

(load "../common/5.2.1-the-machine-model.scm")

(define count-leaves-machine
  (make-machine
   '(tree count temp continue)
   (list (list 'null? null?) (list 'pair? pair?) 
         (list '+ +) (list 'car car) (list 'cdr cdr))
   '(count-leaves
     (assign continue (label done))
     (assign count (const 0))
     
     loop
     (test (op null?) (reg tree))
     (branch (label null-tree))
     (test (op pair?) (reg tree))
     (branch (label pair-tree))
     (assign count (const 1))
     (goto (reg continue))
     
     pair-tree
     (save tree)
     (save continue)
     (assign continue (label after-pair-tree-1))
     (assign tree (op car) (reg tree))
     (goto (label loop))
     
     after-pair-tree-1
     (restore continue)
     (restore tree)
     (save continue)
     (save count)
     (assign continue (label after-pair-tree-2))
     (assign tree (op cdr) (reg tree))
     (goto (label loop))
     
     after-pair-tree-2
     (assign temp (reg count))
     (restore count)
     (restore continue)
     (assign count (op +) (reg temp) (reg count))
     (goto (reg continue))
     
     null-tree
     (assign count (const 0))
     (goto (reg continue))
     
     done)))

;; test
#|
1 ]=> (set-register-contents! count-leaves-machine 'tree '((1 2) (3 (4 (5 6)))))

;Value: done

1 ]=> (start count-leaves-machine)

;Value: done

1 ]=> (get-register-contents count-leaves-machine 'count)

;Value: 6
|#