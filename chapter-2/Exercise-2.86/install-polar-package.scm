(define (install-polar-package)

  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))

  (define (make-from-mag-ang r a) (cons r a))

  (define (real-part z)
    (mul (magnitude z) (cos (to-number (angle z)))))
  
  (define (imag-part z)
    (mul (magnitude z) (sin (to-number (angle z)))))

  (define (make-from-real-imag x y) 
    (cons (sqrt (add (square (to-number x)) (square (to-number y))))
          (atan (to-number y) (to-number x))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))

  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)

  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar 
       (lambda (r a) (tag (make-from-mag-ang r a))))

  'done)

(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

;;; 新增to-number，遇到rational则将其转换为real
(define (to-number x)
  (define (denom x) (cddr x))
  (define (numer x) (cadr x))
  (cond ((equal? (type-tag x) 'rational)
         (/ (numer x) (denom x)))
        ((equal? (type-tag x) 'real)
         (contents x))
        ((number? x)
         x)
        (else
         (error "to-number: unknown type" x))))