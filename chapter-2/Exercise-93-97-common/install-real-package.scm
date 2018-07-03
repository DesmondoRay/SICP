;;; install-real-package.scm

;;; real安装包
(define (install-real-package)
  (define (tag x)
	(attach-tag 'real x))
  (put 'add '(real real)
	   (lambda (x y) (tag (+ x y))))
  (put 'sub '(real real)
	   (lambda (x y) (tag (- x y))))
  (put 'mul '(real real)
	   (lambda (x y) (tag (* x y))))
  (put 'div '(real real)
	   (lambda (x y) (tag (/ x y))))
  (put 'equ? '(real real)
	   (lambda (x y) (= x y)))
  (put 'make 'real
	   (lambda (x) (tag x)))
  'done)

(define (make-real n)
  ((get 'make 'real) n))