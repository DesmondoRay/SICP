;;; install-complex-zero-package.scm

(define (install-complex-zero-package)
  (put '=zero? '(complex)
       (lambda (x)
         (and (= (real-part x) 0)
              (= (imag-part x) 0))))
'done)