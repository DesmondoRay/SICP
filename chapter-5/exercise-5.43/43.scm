;;; exercise 5.43

(load "../exercise-5.42/42.scm")
(load "../exercise-5.43/scan-out-defines.scm")
(load "../exercise-5.43/let.scm")

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
         (compile (let->combination exp) target linkage ct-env)) ; 新增
        ((if? exp) (compile-if exp target linkage ct-env))
        ((lambda? exp) (compile-lambda exp target linkage ct-env))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage 
                           ct-env))
        ((cond? exp) (compile (cond->if exp) target linkage ct-env))
        ((application? exp)
         (compile-application exp target linkage ct-env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

(define (compile-lambda-body exp proc-entry ct-env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence (scan-out-defines (lambda-body exp)) ; 修改
                       'val 'return
                       (extend-ct-env ct-env formals)))))

;; test
#|
input: 
(compile
 '(define (a)
    (define b 1)
    (define c 2)
    (+ b c))
 'val
 'next
 empty-compile-time-env)

output: 
((env) (val) 
 ((assign val (op make-compiled-procedure) (label entry2) (reg env)) 
  (goto (label after-lambda1)) 
entry2 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const ()) (reg argl) (reg env)) 
  (assign proc (op make-compiled-procedure) (label entry4) (reg env)) 
  (goto (label after-lambda3)) 
entry4 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (c b)) (reg argl) (reg env)) 
  (assign val (const 2)) 
  (perform (op lexical-address-set!) (const (0 0)) (reg env)) 
  (assign val (const ok)) (assign val (const 1)) 
  (perform (op lexical-address-set!) (const (0 1)) (reg env)) 
  (assign val (const ok)) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch7)) 
compiled-branch6 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch7 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call5 
after-lambda3 
  (assign val (const "*unassigned*")) 
  (assign argl (op list) (reg val)) 
  (assign val (const "*unassigned*")) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch10)) 
compiled-branch9
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch10 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call8 
after-lambda1 
  (perform (op define-variable!) (const a) (reg val) (reg env)) 
  (assign val (const ok))))
|#