;;; exercise 5.34

(load "../common/code/ch5-compiler.scm")

(display
 (compile
  '(define (factorial n)
     (define (iter product counter)
       (if (> counter n)
           product
           (iter (* counter product)
                 (+ counter 1))))
     (iter 1 1))
  'val
  'next))

#| output:
((env) (val) 
  ; 保存factorial过程体的入口和env
 ((assign val (op make-compiled-procedure) (label entry24) (reg env)) 
  (goto (label after-lambda23)) 
; 生成(define (factorial n) ...)的过程体
entry24 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (n)) (reg argl) (reg env)) 
  ; 保存iter过程体的入口和env
  (assign val (op make-compiled-procedure) (label entry29) (reg env)) 
  (goto (label after-lambda28)) 
;生成(define (iter product counter) ...)的过程体
entry29 
  ; 设置环境
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (product counter)) (reg argl) (reg env)) 
  ; 计算(> counter n)
  (save continue) 
  (save env) 
  (assign proc (op lookup-variable-value) (const >) (reg env))
  (assign val (op lookup-variable-value) (const n) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const counter) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch44)) 
compiled-branch43 
  (assign continue (label after-call42)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch44 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call42 
  ; 现在val的值为(> counter n)的结果，进行测试
  (restore env) 
  (restore continue) 
  (test (op false?) (reg val)) 
  (branch (label false-branch31)) 
true-branch32 
  ; 结果为product，从iter过程返回到factorial过程
  (assign val (op lookup-variable-value) (const product) (reg env))
  (goto (reg continue)) 
false-branch31 
  (assign proc (op lookup-variable-value) (const iter) (reg env)) 
  ; 计算(+ counter 1)
  (save continue) 
  (save proc) 
  (save env) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (assign val (const 1)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const counter) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch38)) 
compiled-branch37 
  (assign continue (label after-call36)) 
  (assign val (op compiled-procedure-entry) (reg proc)) (goto (reg val)) 
rimitive-branch38 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call36 
  (assign argl (op list) (reg val))
  ; 计算(* product counter)
  (restore env) (save argl) 
  (assign proc (op lookup-variable-value) (const *) (reg env))
  (assign val (op lookup-variable-value) (const product) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lookup-variable-value) (const counter) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch35)) 
compiled-branch34 
  (assign continue (label after-call33)) 
  (assign val (op compiled-procedure-entry) (reg proc)) (goto (reg val)) 
primitive-branch35 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call33 
  (restore argl) 
  ; 得到调用iter过程的参数list
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch41)) 
compiled-branch40 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch41 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call39 
after-if30 
after-lambda28 ; (define (iter product counter) ...)过程体结束
  (perform (op define-variable!) (const iter) (reg val) (reg env)) 
  (assign val (const ok)) 
  ; 计算(iter 1 1) 
  (assign proc (op lookup-variable-value) (const iter) (reg env)) 
  ; 构建argl 
  (assign val (const 1)) 
  (assign argl (op list) (reg val)) 
  (assign val (const 1)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch27)) 
compiled-branch26 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch27 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call25 
after-lambda23 ; (define (factorial n) ...)过程体结束
  (perform (op define-variable!) (const factorial) (reg val) (reg env)) 
  (assign val (const ok))))
|#