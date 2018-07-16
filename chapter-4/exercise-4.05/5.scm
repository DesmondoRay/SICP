;;; exercise 4.5

(load "../exercise-4.03/3.scm")

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

;; 判断该clause是否为=>语法
(define (cond-=>? actions)
  (and (pair? actions)
	   (eq? '=> (car actions))))

(define (expand-clauses clauses)
  (if (null? clauses)
	  'false
	  (let ((first (car clauses))
			(rest (cdr clauses)))
		(if (cond-else-clause? first)
			(if (null? rest)
				(sequence->exp (cond-actions first))
				(error "ELSE clause isn't last -- COND->IF"
					   clauses))
			(let ((actions (cond-actions first))
				  (predicate (cond-predicate first)))
			  (if (cond-=>? actions)  ; 修改
				  (make-if predicate
						   ; 生成过程时，需要将过程和参数作为一个list
						   (list (cadr actions) predicate) 
						   (expand-clauses rest))
				  (make-if predicate
						   (sequence->exp actions)
						   (expand-clauses rest))))))))

(put 'op 'cond (lambda (exp env)
				 (eval-in-4 (cond->if exp) env)))


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define a (cons 1 2))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(cond (a => car) (else 'false))  ; 测试新语法

;;; M-Eval value: 
1

;;; M-Eval input: 
(cond ((= 2 (car a)) (car a)) (else (cdr a)))  ; 测试常规语法

;;; M-Eval value: 
2
|#
