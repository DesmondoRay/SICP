;;; exercise 5.33

;; 在编译(* (factorial (- n 1) n))的过程中，需要(save argl)和(restore argl)
;; 在编译(* n (factorial-alt (- n 1)))的过程中，需要(save env)和(restore env)
;; 编译(factorial n)的结果见：../common/test-compiler.scm

(load "../common/code/ch5-compiler.scm")

(display
 (compile
  '(define (factorial-alt n)
     (if (= n 1)
         1
         (* n (factorial-alt (- n 1)))))
  'val
  'next))

#| output:
((env) (val) 
 ((assign val (op make-compiled-procedure) (label entry19) (reg env)) 
  (goto (label after-lambda18)) 
entry19 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (n)) (reg argl) (reg env)) 
  (save continue) 
  (save env) 
  (assign proc (op lookup-variable-value) (const =) (reg env)) 
  (assign val (const 1))
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const n) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch34)) 
compiled-branch33 
  (assign continue (label after-call32)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch34 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call32 
  (restore env) 
  (restore continue) 
  (test (op false?) (reg val)) 
  (branch (label false-branch21)) 
true-branch22 
  (assign val (const 1)) 
  (goto (reg continue)) 
false-branch21 
  (assign proc (op lookup-variable-value) (const *) (reg env)) 
  (save continue) 
  (save proc) 
  (save env) 
  (assign proc (op lookup-variable-value) (const factorial-alt) (reg env)) 
  (save proc) 
  (assign proc (op lookup-variable-value) (const -) (reg env)) 
  (assign val (const 1)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const n) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch25)) 
compiled-branch24 
  (assign continue (label after-call23))
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch25 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call23 
  (assign argl (op list) (reg val)) 
  (restore proc)
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch28)) 
compiled-branch27 
  (assign continue (label after-call26)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch28 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call26 
  (assign argl (op list) (reg val)) 
  (restore env) 
  (assign val (op lookup-variable-value) (const n) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch31)) 
compiled-branch30
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch31 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call29 
after-if20 
after-lambda18 
  (perform (op define-variable!) (const factorial-alt) (reg val) (reg env)) 
  (assign val (const ok))))
|#