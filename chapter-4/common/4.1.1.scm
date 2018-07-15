;;; 4.1.1.scm
;;; page 254

;; 过程参数
(define (list-of-values exps env)
  (if (no-operands? exps)
	  '()
	  (cons (eval (first-operand exps) env)
			(list-of-valuse (rest-operands exps) env))))

;; 条件
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
	  (eval (if-consequent exp) env)
	  (eval (if-alternative exp) env)))

;; 序列
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
		(else (eval (first-exp exps) env)
			  (eval-sequence (rest-exps exps) env))))

;; 赋值和定义
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
					   (eval (assignment-value exp) env)
					   env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
					(eval (definition-value exp) env)
					env)
  'ok)
