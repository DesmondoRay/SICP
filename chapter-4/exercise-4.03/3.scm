;;; exercise-4.3

(load "make-table.scm")
(load "put-get.scm")
(load "eval-package.scm")
(install-eval-package)

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
		((variable? exp) (lookup-variable-value exp env))
		((get 'op (car exp)) ((get 'op (car exp)) exp env))
		((application? exp)
		 (apply (eval (operator exp) env)
				(list-of-values (operands exp) env)))
		(else
		 (error "Unknown expression type -- EVAL" exp))))

;; 需要加入新的操作时，将操作类型和操作过程put进table即可。
