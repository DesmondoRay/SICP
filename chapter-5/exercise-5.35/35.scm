;;; exercise 5.35

(define (f x)
  (+ x (g (+ x 2))))

;; test
(load "../common/code/ch5-compiler.scm")
(display
 (compile
  '(define (f x)
     (+ x (g (+ x 2))))
  'val
  'next))

#| output:
((env) (val) 
 ((assign val (op make-compiled-procedure) (label entry13) (reg env)) 
  (goto (label after-lambda12)) 
entry13 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env)) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (save continue) 
  (save proc) 
  (save env) 
  (assign proc (op lookup-variable-value) (const g) (reg env)) 
  (save proc) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (assign val (const 2)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const x) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch16)) 
compiled-branch15 
  (assign continue (label after-call14))
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch16 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call14 
  (assign argl (op list) (reg val)) 
  (restore proc) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch19)) 
compiled-branch18 
  (assign continue (label after-call17)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch19 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call17 
  (assign argl (op list) (reg val)) 
  (restore env)
  (assign val (op lookup-variable-value) (const x) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc)
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch22)) 
compiled-branch21 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch22 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call20 
after-lambda12 
  (perform (op define-variable!) (const f) (reg val) (reg env)) 
  (assign val (const ok))))
|#