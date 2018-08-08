;;; exercise 5.38 c)

(load "38-d.scm")

(display
 (compile
  '(define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n)))
  'val
  'next))

#|
((env) 
 (val) 
 ((assign val (op make-compiled-procedure) (label entry2) (reg env)) 
  (goto (label after-lambda1)) 
entry2 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (n)) (reg argl) (reg env)) 
  (assign arg2 (const 1)) 
  (assign arg1 (op lookup-variable-value) (const n) (reg env)) 
  (assign val (op =) (reg arg1) (reg arg2)) 
  (test (op false?) (reg val)) 
  (branch (label false-branch4)) 
true-branch5 
  (assign val (const 1)) 
  (goto (reg continue)) 
false-branch4 
  (save continue) 
  (assign arg2 (op lookup-variable-value) (const n) (reg env)) 
  (save arg2) 
  (assign proc (op lookup-variable-value) (const factorial) (reg env)) 
  (assign arg2 (const 1)) 
  (assign arg1 (op lookup-variable-value) (const n) (reg env)) 
  (assign val (op -) (reg arg1) (reg arg2)) 
  (assign argl (op list) (reg val)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch8)) 
compiled-branch7 
  (assign continue (label proc-return9)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
proc-return9 
  (assign arg1 (reg val)) 
  (goto (label after-call6)) 
primitive-branch8 
  (assign arg1 (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call6 
  (restore arg2) 
  (assign val (op *) (reg arg1) (reg arg2)) 
  (restore continue) 
  (goto (reg continue)) 
after-if3 after-lambda1 
  (perform (op define-variable!) (const factorial) (reg val) (reg env)) 
  (assign val (const ok))))
|#