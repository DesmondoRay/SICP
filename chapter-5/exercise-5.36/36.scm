;;; exercise 5.36

;; 求值顺序从右到左;
;; 修改之后，会让构造参数表的代码变得地低效，特别是在参数个数很多的情况下，
;; 因为append过程比较低效，见2.2节，68页append的定义。

(load "../common/code/ch5-compiler.scm")

;; 修改construct-arglist过程，不把operand-codes反转
(define (construct-arglist operand-codes)
  ; (let ((operand-codes (reverse operand-codes)))  ; delete
    (if (null? operand-codes)
        (make-instruction-sequence '() '(argl)
         '((assign argl (const ()))))
        (let ((code-to-get-last-arg
               (append-instruction-sequences
                (car operand-codes)
                (make-instruction-sequence '(val) '(argl)
                 '((assign argl (op list) (reg val)))))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving '(env)
               code-to-get-last-arg
               (code-to-get-rest-args
                (cdr operand-codes)))))))

;; 修改code-to-get-rest-args过程，将cons改为append，并调换val和argl的位置
(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
         (preserving '(argl)
          (car operand-codes)
          (make-instruction-sequence '(val argl) '(argl)
           '((assign argl
              (op append) (reg argl) (reg val))))))) ; changed
    (if (null? (cdr operand-codes))
        code-for-next-arg
        (preserving '(env)
         code-for-next-arg
         (code-to-get-rest-args (cdr operand-codes))))))

;; test
(display
 (compile
  '(define (f x)
     (+ x (g (+ x 2))))
  'val
  'next))

#| output:
((env) (val) 
 ((assign val (op make-compiled-procedure) (label entry2) (reg env)) 
  (goto (label after-lambda1)) 
entry2 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env)) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (save continue) 
  (save proc) 
  (assign val (op lookup-variable-value) (const x) (reg env))   ; first: x
  (assign argl (op list) (reg val)) 
  (save argl) 
  (assign proc (op lookup-variable-value) (const g) (reg env))  ; then: g
  (save proc) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (assign val (op lookup-variable-value) (const x) (reg env))   ; first: x
  (assign argl (op list) (reg val)) 
  (assign val (const 2))                                        ; then: 2
  (assign argl (op append) (reg argl) (reg val)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch5)) 
compiled-branch4 
  (assign continue (label after-call3)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch5 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call3 
  (assign argl (op list) (reg val)) 
  (restore proc) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch8)) 
compiled-branch7 
  (assign continue (label after-call6)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val))
primitive-branch8 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call6 
  (restore argl) 
  (assign argl (op append) (reg argl) (reg val)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch11)) 
compiled-branch10 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch11 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue)) 
after-call9 
after-lambda1 
  (perform (op define-variable!) (const f) (reg val) (reg env)) 
  (assign val (const ok))))
|#