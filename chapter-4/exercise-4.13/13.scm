;;; exercise 4.13

(load "../exercise-4.03/3.scm")

(define (unbound-variable exp) (cadr exp))

(define (eval-unbound exp env)
  (make-unbound! (unbound-variable exp) env)
  'ok)

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
	(define (scan vars vals previous-vars previous-vals)
	  (cond ((null? vars)
			 (error
			  "variable is not in the environment -- MAKE-UNBOUND!" var))
			((eq? var (car vars))
			 (set-cdr! previous-vars (cdr vars))
			 (set-cdr! previous-vals (cdr vals)))
			(else (scan (cdr vars) (cdr vals) vars vals))))
	(let* ((vars (frame-variables frame))
		   (vals (frame-values frame))
		   (first-var (car vars)))
	  (cond ((eq? first-var var)  ; 判断第一个是否为指定的var
			 (set-car! frame (cdr vars))
			 (set-cdr! frame (cdr vals)))
			(else
			 (scan (cdr vars) (cdr vals) vars vals))))))

;; 将eval-unbound加入求值器
(put 'op 'make-unbound! eval-unbound)


#| 
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define a 5)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(define b 3)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(make-unbound! b)

;;; M-Eval value: 
ok

;;; M-Eval input: 
b
;Unbound variable b
|#
