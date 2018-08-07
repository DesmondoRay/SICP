;;; exercise 5.37

(load "../common/code/ch5-compiler.scm")

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        ;(if (and (needs-register? seq2 first-reg)      ; deleted
                 ;(modifies-register? seq1 first-reg))  ; deleted
            (preserving (cdr regs)
             (make-instruction-sequence
              (list-union (list first-reg)
                          (registers-needed seq1))
              (list-difference (registers-modified seq1)
                               (list first-reg))
              (append `((save ,first-reg))
                      (statements seq1)
                      `((restore ,first-reg))))
             seq2))))
            ;(preserving (cdr regs) seq1 seq2)))))      ; deleted

;; 编译练习5.35生成的指令数为54条，而修改后生成的指令数为101条。(包括label在内)

;; test
(display
 (compile
  '(define (f x)
     (+ x (g (+ x 2))))
  'val
  'next))

#| output: 
((continue env) (val) 
 ((save continue) 
  (save env) 
  (save continue) 
  (assign val (op make-compiled-procedure) (label entry2) (reg env)) 
  (restore continue) 
  (goto (label after-lambda1)) 
entry2 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env)) 
  (save continue) 
  (save env) 
  (save continue) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (restore continue) 
  (restore env) 
  (restore continue) 
  (save continue) 
  (save proc) 
  (save env) 
  (save continue)
  (save env)
  (save continue)
  (assign proc (op lookup-variable-value) (const g) (reg env)) 
  (restore continue) 
  (restore env) 
  (restore continue) 
  (save continue) 
  (save proc) 
  (save continue) 
  (save env) 
  (save continue) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (restore continue) 
  (restore env) 
  (restore continue) 
  (save continue) 
  (save proc) 
  (save env) 
  (save continue) 
  (assign val (const 2)) 
  (restore continue) 
  (assign argl (op list) (reg val)) 
  (restore env) 
  (save argl) 
  (save continue) 
  (assign val (op lookup-variable-value) (const x) (reg env)) 
  (restore continue) 
  (restore argl) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch5)) 
compiled-branch4 
  (assign continue (label after-call3)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch5 
  (save continue) 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (restore continue) 
after-call3 
  (assign argl (op list) (reg val)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch8))
compiled-branch7 
  (assign continue (label after-call6)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch8 
  (save continue) 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (restore continue) 
after-call6 
  (assign argl (op list) (reg val)) 
  (restore env) 
  (save argl) 
  (save continue) 
  (assign val (op lookup-variable-value) (const x) (reg env)) 
  (restore continue) 
  (restore argl) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc) (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch11)) 
compiled-branch10 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch11 
  (save continue) 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (restore continue)
  (goto (reg continue)) 
after-call9 
after-lambda1 
  (restore env) 
  (perform (op define-variable!) (const f) (reg val) (reg env)) 
  (assign val (const ok)) 
  (restore continue)))
|#