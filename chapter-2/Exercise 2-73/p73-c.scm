(define (install-exponentiation-package)
  ;; internal procedures
  (define (base s) (car s))

  (define (exponent s) (cadr s))
  
  (define (make-exponentiation e1 e2)
    (cond ((=number? e2 0) 1)
		  ((=number? e2 1) e1)
		  ((and (number? e1) (number? e2)) (exp e1 e2))
		  (else (attach-tag '** e1 e2))))
  
  ;; interface to the rest of the system
  (put 'base '** base)
  (put 'exponent '** exponent)
  (put 'make-exponentiation '** make-exponentiation)
  
  (put 'deriv '**
	   (lambda (exp var)
		 (make-product
		   (make-product
		     (exponent exp)
		     (make-exponentiation (base exp)
							      (- (exponent exp) 1)))
		   (deriv (base exp) var))))
  
  'done)

(define (base s)
  ((get 'base '**) (contents s)))

(define (exponent s)
  ((get 'exponent '**) (contents s)))

(define (make-exponentiation x y)
  ((get 'make-exponentiation '**) x y))