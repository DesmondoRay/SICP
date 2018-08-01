;;; exercise 5.4

;; a) recursion
(controller
 (assign b (op read))
 (assign n (op read))
 
 (assign continue (label expt-done))
 
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
 (goto (reg coutinue))
 
 base-case
 (assign val (const 1))
 (goto (reg continue))
 
 expt-done
(perform (op print) (reg val)))


;; b) iteration
(controller
 (assign b (op read))
 (assign n (op read))
 (assign counter (reg n))
 (assign product (const 1))
 
 test-expt
 (test (op =) (reg counter) (const 0))
 (branch (label expt-done))
 (assign product (op *) (reg b) (reg product))
 (assign counter (op -) (reg counter) (const 1))
 (goto (label test-expt))
 expt-done
 (perform (op print) (reg product)))