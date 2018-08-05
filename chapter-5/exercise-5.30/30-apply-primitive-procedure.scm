;;; exercise 5.30 b)

(define (apply-primitive-procedure proc args)
  (let ((p (primitive-implementation proc)))
	(cond ((or (eq? p car)
			   (eq? p cdr))
		   (safe-car-cdr p args))
		  ((eq? p /)
		   (safe-div args))
		  (else
		   (apply-in-underlying-scheme
			p args)))))

(define (safe-car-cdr proc args)
  (if (not (pair? (car args)))
	  '*error-argument-to-car-or-cdr*
	  (apply-in-underlying-scheme proc args)))

(define (safe-div args)
  (if (= 0 (cadr args))
	  '*division-by-zero-error*
	  (apply-in-underlying-scheme / args)))
