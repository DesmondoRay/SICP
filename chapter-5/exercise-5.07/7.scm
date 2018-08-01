;;; exercise 5.7

(load "../common/5.2.1-the-machine-model.scm") ;由5.2节实现

;; 递归
(define expt-machine-recursion
  (make-machine
   '(b n continue val)
   (list (list '= =) (list '- -) (list '* *))
   '((assign continue (label expt-done))
     
     expt-loop
     (test (op =) (reg n) (const 0))
     (branch (label base-case))
     (save continue)
     (assign n (op -) (reg n) (const 1))
     (assign continue (label after-expt))
     (goto (label expt-loop))
     
     after-expt
     (restore continue)
     (assign val (op *) (reg b) (reg val))
     (goto (reg continue))
 
     base-case
     (assign val (const 1))
     (goto (reg continue))
 
     expt-done)))

#| test: expt-machine-recursion
1 ]=> (set-register-contents! expt-machine-recursion 'b 3)

;Value: done

1 ]=> (set-register-contents! expt-machine-recursion 'n 3)

;Value: done

1 ]=> (start expt-machine-recursion)

;Value: done

1 ]=> (get-register-contents expt-machine-recursion 'val)

;Value: 27
|#

;; 迭代
(define expt-machine-iter
  (make-machine
   '(b n counter product)
   (list (list '= =) (list '* *) (list '- -))
   '((assign counter (reg n))
     (assign product (const 1))
     test-expt
     (test (op =) (reg counter) (const 0))
     (branch (label expt-done))
     (assign product (op *) (reg b) (reg product))
     (assign counter (op -) (reg counter) (const 1))
     (goto (label test-expt))
     expt-done)))

#| test: expt-machine-iter
1 ]=> (set-register-contents! expt-machine-iter 'b 3)

;Value: done

1 ]=> (set-register-contents! expt-machine-iter 'n 3)

;Value: done

1 ]=> (start expt-machine-iter)

;Value: done

1 ]=> (get-register-contents expt-machine-iter 'product)

;Value: 27
|#