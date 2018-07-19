;;; exercise 4.33
;;; '(a b c) 在求值器中的值 (quote (a b c))

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")

(define (eval-in-4 exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp env))  ; 修改，将env添加为参数
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval-in-4 (cond->if exp) evn))
        ((application? exp)
         (apply-in-4 (actual-value (operator exp) env)
                     (operands exp)
                     env))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval-in-4 (make-list text) env)
        text)))

(define (make-list text)
  (if (null? text) 
      (list 'quote '())
      (list 'cons
            (list 'quote (car text))
            (make-list (cdr text)))))

;; 在全局环境内添加惰性list到相关定义
(load "../common/lazy-list.scm")
(define-lazy-list-in-env the-global-environment)


; (driver-loop)

#| test: lazy-list
;;; L-Eval input:
(car '(a b c))

;;; L-Eval value:
a

;;; L-Eval input:
(define f '(1 2))

;;; L-Eval value:
ok

;;; L-Eval input:
(car f)

;;; L-Eval value:
1

;;; L-Eval input:
f

;;; L-Eval value:
(compound-procedure (m) ((m x y)) <procedure-env>)
|#
