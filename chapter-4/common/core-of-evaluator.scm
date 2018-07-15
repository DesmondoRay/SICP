;;; The Core of the Evaluator
;;; page 254

; (load "../common/eval.scm") ;练习4.3重新定义的一个数据导向的eval
(load "../common/apply.scm")

;; 过程参数
(define (list-of-values exps env)
  (if (no-operands? exps)
	  '()
	  (cons (eval-in-4 (first-operand exps) env)
			(list-of-values (rest-operands exps) env))))

;; 条件
(define (eval-if exp env)
  (if (true? (eval-in-4 (if-predicate exp) env))
	  (eval-in-4 (if-consequent exp) env)
	  (eval-in-4 (if-alternative exp) env)))

;; 序列
(define (eval-sequence exps env)
  (cond ((last-exp? exps)
		 (eval-in-4 (first-exp exps) env))
		(else
		 (eval-in-4 (first-exp exps) env)
		 (eval-sequence (rest-exps exps) env))))

;; 赋值和定义
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
					   (eval-in-4 (assignment-value exp) env)
					   env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
					(eval-in-4 (definition-value exp) env)
					env)
  'ok)