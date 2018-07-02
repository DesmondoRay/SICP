;;; install-raise-package.scm


(define (install-scheme-number-raise-package)
  (put 'raise '(scheme-number)
       (lambda (x)
         (make-rational x 1)))
  'done)

(define (install-rational-raise-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  
  (put 'raise '(rational)
       (lambda (x)
         (make-real (/ (numer x) (denom x)))))
  'done)

(define (install-real-raise-package)
  (put 'raise '(real)
	   (lambda (x)
		 (make-complex-from-real-imag x 0)))
  'done)

(define (install-complex-raise-package)
  (put 'raise '(complex)
	   (lambda (x)
		 (error "Reach the tower top")))
  'done)

(install-scheme-number-raise-package)
(install-rational-raise-package)
(install-real-raise-package)
(install-complex-raise-package)