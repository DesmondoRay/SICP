;;; install-project-package.scm

(define (install-scheme-number-project-package)
  (put 'project '(scheme-number)
       (lambda (x)
         (error "project--reach the tower bottom")))
  'done)

(define (install-rational-project-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (put 'project '(rational)
       (lambda (x)
         (if (= 1 (denom x))
             (numer x)
             (attach-tag 'rational x))))
  'done)

(define (install-real-project-package)
  (put 'project '(real)
       (lambda (x)
         (if (integer? x)
             x
             (make-real x))))
  'done)

(define (install-complex-project-package)
  (put 'project '(complex)
       (lambda (x)
         (if (= (imag-part x) 0)
             (make-real (real-part x))
             (attach-tag 'complex x))))
  'done)

(install-scheme-number-project-package)
(install-rational-project-package)
(install-real-project-package)
(install-complex-project-package)

(define (drop x)
  (if (equal? (type-tag x) 'scheme-number)
      x
      (let ((project-x (apply-generic 'project x)))
        (if (equal? (type-tag project-x) (type-tag x))
            x
            (drop project-x)))))