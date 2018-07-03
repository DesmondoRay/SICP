;;; install-scheme-number-package.scm

(define (install-scheme-number-package)
  (define (tag x)
	(attach-tag 'scheme-number x))
  
  (put 'add '(scheme-number scheme-number)
	   (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
	   (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
	   (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
	   (lambda (x y) (tag (/ x y))))
  (put 'equ? '(scheme-number scheme-number)
	   (lambda (x y) (= x y)))
  (put 'make 'scheme-number
	   (lambda (x) (tag x)))
  
  ;; 由exercise 2-97-b添加
  (define (reduce-integers n d)
	(let ((g (gcd n d)))
	  (list (/ n g) (/ d g))))
  
  (put 'reduce '(scheme-number scheme-number)
	   (lambda (x y) (reduce-integers x y)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
  