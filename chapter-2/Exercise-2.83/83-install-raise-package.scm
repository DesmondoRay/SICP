;;; install-raise-package.scm

(define (install-scheme-number-raise-package)
  (put 'raise '(scheme-number)
       (lambda (x)
         (make-rational x 1)))
  'done)

(define (install-rational-raise-package)
  (put 'raise '(rational)
       (lambda (x)
         (make-from-real-imag x 0)))
  'done)

(define (install-complex-raise-package)
  (put 'raise '(complex)
       (lambda (x)
         (error "Reach the tower top")))
  
  'done)

(install-scheme-number-raise-package)
(install-rational-raise-package)
(install-complex-raise-package)