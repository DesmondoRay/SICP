;;; apply.scm

(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
		 (apply-primitive-procedure procedure arguments))
		((compound-procedure? procedure)
		 (eval-sequence
		  (procedure-body procedure)
		  (extend-environment
		   (procedure-parameters procedure)
		   argument
		   (procedure-enviroment procedure))))
		(else
		 (error "Unknown procedure type -- APPLY" procedure))))