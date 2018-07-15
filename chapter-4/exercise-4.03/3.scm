;;; exercise-4.3
;; 注：将书上的元循环的apply、eval命名为apply-in-4、eval-in-4
;     详见../common/apply.scm

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/make-table.scm")
(load "../common/put-get.scm")

(load "../exercise-4.03/eval-package.scm")
(install-eval-package)

(define (eval-in-4 exp env)
  (cond ((self-evaluating? exp) exp)
		((variable? exp) (lookup-variable-value exp env))
		((quoted? exp) (text-of-quotation exp)) ; 字符串不需要env
		((get 'op (car exp)) ((get 'op (car exp)) exp env))
		((application? exp)
		 (apply-in-4 (eval-in-4 (operator exp) env)
					 (list-of-values (operands exp) env)))
		(else
		 (error "Unknown expression type -- EVAL" exp))))

;; test(交互模式下)
(driver-loop)
;;; M-Eval input: 
(list 1 'a "b")	; test: application? and self-evaluating?

;;; M-Eval value: 
(1 a b)

;;; M-Eval input: 
(define a 3)	; test: definition?

;;; M-Eval value: 
ok

;;; M-Eval input: 
a				; test: variable?

;;; M-Eval value: 
3

;;; M-Eval input: 
(set! a 5)		; tets: assignment?

;;; M-Eval value: 
ok

;;; M-Eval input: 
a

;;; M-Eval value: 
5

;;; M-Eval input: 
(if (= a 0) 0 (begin (display "positive") a))	; test: if? and begin?
positive
;;; M-Eval value: 
5

;;; M-Eval input: 
(cond ((= a 0) 0) ((= a 3) 3) (else a))			; test: cond?

;;; M-Eval value: 
5

;;; M-Eval input: 
(define x (lambda (a b) (+ a b)))				; test: lambda?

;;; M-Eval value: 
ok

;;; M-Eval input: 
(x 3 4)

;;; M-Eval value: 
7