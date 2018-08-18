(define (install-rectangular-package)
  
  ;;internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))

  (define (make-from-real-imag x y) (cons x y))

  (define (magnitude z)
    (sqrt (add (square (to-number (real-part z)))
               (square (to-number (imag-part z))))))
  
  (define (angle z)
    (atan (to-number (imag-part z)) (to-number (real-part z))))

  (define (make-from-mag-ang r a) 
    (cons (mul r (cos (to-number a))) (mul r (sin (to-number a)))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))

  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)

  (put 'make-from-real-imag 'rectangular 
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular 
       (lambda (r a) (tag (make-from-mag-ang r a))))

  'done)

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

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
