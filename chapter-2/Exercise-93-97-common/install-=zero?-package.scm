;;; install-=zero?-package.scm

(define (install-rational-zero-package)
  (define (numer x)
    (car x))
  
  (put '=zero? '(rational)
       (lambda (x)
         (= (numer x) 0)))
'done)

(define (install-scheme-number-zero-package)
  (put '=zero? '(scheme-number)
       (lambda (x)
         (= x 0)))
'done)

(define (install-real-zero-package)
  (put '=zero? '(real)
       (lambda (x)
         (= x 0)))
  'done)

(define (install-complex-zero-package)
  (put '=zero? '(complex)
       (lambda (x)
         (and (= (real-part x) 0)
              (= (imag-part x) 0))))
'done)

(install-scheme-number-zero-package)
(install-complex-zero-package)
(install-rational-zero-package)
(install-real-zero-package)