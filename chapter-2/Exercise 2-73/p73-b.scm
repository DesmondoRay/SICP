(define (install-sum-package)
  ;; internal procedures
  (define (make-sum a1 a2)
  	(cond ((=number? a1 0) a2)
		  ((=number? a2 0) a1)
		  ((and (number? a1) (number? a2)) (+ a1 a2))
		  (else (attach '+ a1 a2))))
  
  (define (addend s) (car s))

  (define (augend s) (cadr s))
  
  ;; interface to the rest of the system
  (put 'addend '+ addend)
  (put 'augend '+ augend)
  (put 'make-sum '+ make-sum)
  
  (put 'deriv '+
	   (lambda (exp var)
		 (make-sum (deriv (addend exp) var)
				   (deriv (augend exp) var))))
  
  'done)

(define (make-sum x y) 
  ((get 'make-sum '+) x y))

(define (addend sum)
    ((get 'addend '+) (contents sum)))

(define (augend sum)
    ((get 'augend '+) (contents sum)))



(define (install-product-package)
  ;; internal procedures
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
		  ((=number? m1 1) m2)
		  ((=number? m2 1) m1)
		  ((and (number? m1) (number? m2)) (* m1 m2))
		  (else (attach-tag '* m1 m2))))
  
  (define (multiplier p) (car p))

  (define (multiplicand p) (cadr p))
  
  ;; interface to the rest of the system
  (put 'multiplier '* multiplier)
  (put 'multiplicand '* multiplicand)
  (put 'make-product '* make-product)
  (put 'deriv '*
	   (lambda (exp var)
		 (make-sum
		  (make-product (multiplier exp)
						(deriv (multiplicand exp) var))
		  (make-product (deriv (multiplier exp) var)
						(multiplicand exp)))))
  
  'done)

(define (multiplier p)
  ((get 'multiplier '*) (contents p)))

(define (multiplicand p)
  ((get 'multiplicand '*) (contents p)))

(define (make-product x y)
  ((get 'make-product '*) x y))


