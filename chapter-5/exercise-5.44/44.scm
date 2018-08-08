;;; exercise 5.44

;; 注意加载顺序
(load "../exercise-5.38/38-d.scm")
(load "../exercise-5.43/43.scm")

(define (compile exp target linkage ct-env)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage ct-env))
        ((assignment? exp)
         (compile-assignment exp target linkage ct-env))
        ((definition? exp)
         (compile-definition exp target linkage ct-env))
        ((let? exp) 
         (compile (let->combination exp) target linkage ct-env))
        ((if? exp) (compile-if exp target linkage ct-env))
        ((lambda? exp) (compile-lambda exp target linkage ct-env))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage 
                           ct-env))
        ((cond? exp) (compile (cond->if exp) target linkage ct-env))
        ((open-coded? exp ct-env ) ; 需要将ct-env作为参数
         (compile-open-code exp target linkage)) ; 新增
        ((application? exp)
         (compile-application exp target linkage ct-env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;; 修改练习5.38的 open-coded? 过程
(define (open-coded? exp ct-env) 
  (and (memq (operator exp) '(= + - *))
       (eq? 'not-found 
            (find-variable (operator exp) ct-env))))


;; test
#|
input: 
(compile 
 '(lambda (+ * a b x y)
    (+ (* a x) (* b y))) 
 'val 
 'next 
 empty-compile-time-env)

output:
((env) (val) 
 ((assign val (op make-compiled-procedure) (label entry13) (reg env)) 
  (goto (label after-lambda12)) 
entry13 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (+ * a b x y)) (reg argl) (reg env)) 
  (assign proc (op lexical-address-lookup) (const (0 0)) (reg env)) 
  (save continue)
  (save proc) 
  (save env) 
  (assign proc (op lexical-address-lookup) (const (0 1)) (reg env)) 
  (assign val (op lexical-address-lookup) (const (0 5)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 3)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
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
  (save argl) 
  (assign proc (op lexical-address-lookup) (const (0 1)) (reg env)) 
  (assign val (op lexical-address-lookup) (const (0 4)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env)) 
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
  (restore argl) 
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
after-lambda12))
|#