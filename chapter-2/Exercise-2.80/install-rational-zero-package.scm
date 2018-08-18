;;; install-rational-zero-package.scm

(define (install-rational-zero-package)
  (define (numer x)
        (car x))
  
  (put '=zero? '(rational)
       (lambda (x)
         (= (numer x) 0)))
'done)