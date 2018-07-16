;;; exercise 4.4 (派生表达式）

(load "../exercise-4.03/3.scm")

(define (and-clauses exp) (cdr exp))
(define (or-clauses exp) (cdr exp))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (last-exp? seq) (null? (cdr seq)))
(define (empty-exp? exp) (null? exp))

(define (eval-and exps env)
  (eval-in-4 (and->if exps) env))

(define (and->if exps)
  (if (last-exp? exps)
	  (first-exp exps)
	  (make-if (first-exp exps) ;若first-exp为真，则以rest-exps作为参数调用and->if
			   (and->if (rest-exps exps))
			   'false)))

(define (eval-or exps env)
  (eval-in-4 (or->if exps) env))

(define (or->if exps)
  (if (empty-exp? exps)
	  'false
	  (make-if (first-exp exps) ;若first-exp为真，则返回true
			   (first-exp exps)
			   (or->if (rest-exps exps))))) ; 否则以rest-exps作为参数调用or->if


;; 将eval-and, eval-or加入table
(put 'op 'and (lambda (exp env)
				(eval-and (and-clauses exp) env)))
(put 'op 'or (lambda (exp env)
			   (eval-or (or-clauses exp) env)))
 
 
 #|
; test(交互模式下)
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