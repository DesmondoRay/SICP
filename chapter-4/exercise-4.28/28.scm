;;; exercise 4.28

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")


#|
;; test1: 使用 actual-value
(driver-loop)

;;; L-Eval input:
(define map
  (lambda (op list)
    (if (null? list)
        '()
        (cons (op (car list))
              (map op (cdr list))))))

;;; L-Eval value:
ok

;;; L-Eval input:
(map car (list (list 2 3) (list 4 5)))

;;; L-Eval value:
(2 4)

;; 结果正常
|#

(define (eval-in-4 exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
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
         (display "*** exercise 4.28 test ***")  ; 用于测试
         (apply-in-4 (eval-in-4 (operator exp) env)
                     (operands exp)
                     env))
        (else
         (error "Unknown expression type -- EVAL" exp))))


#|
;; test2: 使用 eval
(driver-loop)

;;; L-Eval input:
(define map
  (lambda (op list)
    (if (null? list)
        '()
        (cons (op (car list))
              (map op (cdr list))))))

;;; L-Eval value:
ok

;;; L-Eval input:
(map car (list (list 2 3) (list 4 5)))
;Unknown procedure type: APPLY (thunk op (... ...))
;; 提示错误
|#

;; 说明，将过程作为参数时，如果用eval去求值，会出现错误。
