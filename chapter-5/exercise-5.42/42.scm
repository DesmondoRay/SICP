;;; exercise 5.42

(load "../exercise-5.40/40.scm")
(load "../exercise-5.41/41.scm")
;; 若要进行求值，则需要在eceval-operations中添加
;; lexical-address-lookup和lexical-address-set!

(define (compile-variable exp target linkage ct-env)
  (let ((lex-addr (find-variable exp ct-env)))
    (end-with-linkage 
     linkage
     (make-instruction-sequence 
      '(env) (list target)
      (if (eq? lex-addr 'not-found)
          `((assign ,target
                    (op lookup-variable-value)
                    (const ,exp)
                    (reg env)))
          `((assign ,target
                    (op lexical-address-lookup)
                    (const ,lex-addr)
                    (reg env))))))))

(define (compile-assignment exp target linkage ct-env)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next ct-env)))
    (let ((lex-addr (find-variable var ct-env)))
      (end-with-linkage 
       linkage
       (preserving
        '(env)
        get-value-code
        (make-instruction-sequence
         '(env val) (list target)
         (if (eq? lex-addr 'not-found)
             `((perform (op set-variable-value!)
                        (const ,var)
                        (reg val)
                        (reg env))
               (assign ,target (const ok)))
             `((perform (op lexical-address-set!)
                        (const ,lex-addr)
                        (reg env))
               (assign ,target (const ok))))))))))

;; test
#|
; input: 
(compile '((lambda (x y)
             (lambda (a b c d e)
               ((lambda (y z) (* x y z))
                (* a b x)
                (+ c d x))))
            3 4)
         'val
         'next
         empty-compile-time-env)

; output: 
((env) (env proc argl continue val) 
 ((assign proc (op make-compiled-procedure) (label entry2) (reg env))
  (goto (label after-lambda1)) 
entry2 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (x y)) (reg argl) (reg env)) 
  (assign val (op make-compiled-procedure) (label entry4) (reg env)) 
  (goto (reg continue)) 
entry4 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (a b c d e)) (reg argl) (reg env)) 
  (assign proc (op make-compiled-procedure) (label entry12) (reg env)) 
  (goto (label after-lambda11)) 
entry12 
  (assign env (op compiled-procedure-env) (reg proc)) 
  (assign env (op extend-environment) (const (y z)) (reg argl) (reg env)) 
  (assign proc (op lookup-variable-value) (const *) (reg env)) 
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (assign val (op lexical-address-lookup) (const (2 0)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch15)) 
compiled-branch14 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch15 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call13 
after-lambda11 
  (save continue) 
  (save proc) 
  (save env) 
  (assign proc (op lookup-variable-value) (const +) (reg env)) 
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 3)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch10)) 
compiled-branch9 
  (assign continue (label after-call8)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch10 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call8 
  (assign argl (op list) (reg val)) 
  (restore env) 
  (save argl) 
  (assign proc (op lookup-variable-value) (const *) (reg env)) 
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env)) 
  (assign argl (op list) (reg val)) 
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch7)) 
compiled-branch6 
  (assign continue (label after-call5)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch7 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
after-call5 
  (restore argl) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (restore proc) 
  (restore continue) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch18)) 
compiled-branch17 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch18 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  (goto (reg continue)) 
after-call16 
after-lambda3 
after-lambda1 
  (assign val (const 4)) 
  (assign argl (op list) (reg val)) 
  (assign val (const 3)) 
  (assign argl (op cons) (reg val) (reg argl)) 
  (test (op primitive-procedure?) (reg proc)) 
  (branch (label primitive-branch21)) 
compiled-branch20 
  (assign continue (label after-call19)) 
  (assign val (op compiled-procedure-entry) (reg proc)) 
  (goto (reg val)) 
primitive-branch21 
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl)) 
  after-call19))
|#