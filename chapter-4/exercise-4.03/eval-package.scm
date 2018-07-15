;;; eval-package.scm
 
(load "../common/4.1.2.scm")
(load "../common/4.1.1.scm")
(load "../common/cond->if.scm")
 
(define (install-eval-package)
  ;; 将相应的操作加入table
  (put 'op 'quote text-of-quotation)
  (put 'op 'set! eval-assignment)
  (put 'op 'define eval-definition)
  (put 'op 'if eval-if)
  (put 'op 'lambda (lambda (exp env)
					 (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
  (put 'op 'begin (lambda (exp env)
					(eval-sequence (begin-sequence exp) env)))
  (put 'op 'cond (lambda (exp env)
				   (eval (cond->if exp) env)))
  'done)