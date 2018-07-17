;;; exercise-4.3
;; 注：将书上的元循环的apply、eval命名为apply-in-4、eval-in-4
;     详见../common/apply.scm

(load "../common/evaluator-data-structures.scm") ; page 260, 4.1.3
(load "../common/running-evaluator.scm")         ; page 264, 4.1.4
(load "../common/representing-expressions.scm")  ; page 255, 4.1.2
(load "../common/core-of-evaluator.scm")         ; page 252, 4.1.1

(load "../common/make-table.scm")  ; page 186, 3.3.3
(load "../common/put-get.scm")     ; page 187, 3.3.3

(load "../exercise-4.03/eval-package.scm")
(install-eval-package)

(define (eval-in-4 exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ; 字符串常量不需要env，也可以将quote放入数据导向表格内，但需要修改：
        ;    (define (text-of-quotation exp env) (cadr exp))
        ((quoted? exp) (text-of-quotation exp))
        ((get 'op (car exp)) ((get 'op (car exp)) exp env))
        ((application? exp)
         (apply-in-4 (eval-in-4 (operator exp) env)
                     (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))


;; (driver-loop)

#|
;; test(交互模式下)

;;; M-Eval input: 
(list 1 'a "b") ; test: application? and self-evaluating?

;;; M-Eval value: 
(1 a b)

;;; M-Eval input: 
(define a 3)    ; test: definition?

;;; M-Eval value: 
ok

;;; M-Eval input: 
a               ; test: variable?

;;; M-Eval value: 
3

;;; M-Eval input: 
(set! a 5)      ; tets: assignment?

;;; M-Eval value: 
ok

;;; M-Eval input: 
a

;;; M-Eval value: 
5

;;; M-Eval input: 
(if (= a 0) 
    0 
    (begin (display "positive") 
           a))  ; test: if? and begin?
positive
;;; M-Eval value: 
5

;;; M-Eval input: 
(cond ((= a 0) 0) 
      ((= a 3) 3) 
      (else a))         ; test: cond?

;;; M-Eval value: 
5

;;; M-Eval input: 
(define x (lambda (a b) 
            (+ a b)))               ; test: lambda?

;;; M-Eval value: 
ok

;;; M-Eval input: 
(x 3 4)

;;; M-Eval value: 
7
|#