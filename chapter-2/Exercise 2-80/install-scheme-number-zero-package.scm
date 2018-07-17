;;; install-scheme-number-zero-package.scm

(define (install-scheme-number-zero-package)
  (put '=zero? '(scheme-number)
       (lambda (x)
         (= x 0)))
'done)