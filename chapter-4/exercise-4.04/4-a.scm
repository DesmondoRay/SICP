;;; exercise 4.4

(load "../exercise-4.03/3.scm")

(define (and-clauses exp) (cdr exp))
(define (or-clauses exp) (cdr exp))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (last-exp? seq) (null? (cdr seq)))
(define (empty-exp? exp) (null? exp))

(define (eval-and exps env)
  (if (null? exps)
	  'true
	  (let ((first (eval-in-4 (first-exp exps) env)))
		(cond ((last-exp? exps) first)
			  (first 
			   (eval-and (rest-exps exps) env))
			  (else 'false)))))

(define (eval-or exps env)
  (if (null? exps)
	  'false
	  (let ((first (eval-in-4 (first-exp exps) env)))
		(cond ((last-exp? exps) first)
			  (first 'true)
			  (else
			   (eval-or (rest-exps exps) env))))))


;; 将eval-and, eval-or加入table
 (put 'op 'and (lambda (exp env)
				 (eval-and (and-clauses exp) env)))
 (put 'op 'or (lambda (exp env)
				(eval-or (or-clauses exp) env)))
 
 
#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(and true true)

;;; M-Eval value: 
#t

;;; M-Eval input: 
(and true false)

;;; M-Eval value: 
#f

;;; M-Eval input: 
(or false true)

;;; M-Eval value: 
#t

;;; M-Eval input: 
(or false false)

;;; M-Eval value: 
#f
|#