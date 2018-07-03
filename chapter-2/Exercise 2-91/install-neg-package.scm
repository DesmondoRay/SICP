;;; install-neg-package.scm

(define (install-scheme-number-neg-package)
  (put 'neg '(scheme-number)
       (lambda (x)
         (- x)))
'done)

(define (install-rational-neg-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  
  (put 'neg '(rational)
       (lambda (x)
         (make-rational (neg (numer x)) (denom x))))
'done)

(define (install-real-neg-package)
  (put 'neg '(real)
       (lambda (x)
         (make-real (neg x))))
  'done)

(define (install-complex-neg-package)
  (put 'neg '(complex)
       (lambda (x)
         (make-complex-from-real-imag (neg (real-part x))
                                      (neg (imag-part x)))))
'done)

 ;;; exercise 2-88(求负操作)
(define (install-polynomial-neg-package)		 
  (put 'neg '(polynomial)
	   (lambda (x)
		 (make-polynomial-sparse (variable x)
								 (neg-terms (term-list x)))))
  'done)

(define (neg-terms L)
  (if (empty-termlist? L)
	  (the-empty-termlist)
	  (let ((t1 (first-term L)))
		(adjoin-term
		 (make-term (order t1) (neg (coeff t1)))
		 (neg-terms (rest-terms L))))))

(define (install-neg-package)
  (install-scheme-number-neg-package)
  (install-complex-neg-package)
  (install-rational-neg-package)
  (install-real-neg-package)
  (install-polynomial-neg-package))