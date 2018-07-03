;;; install-poly-dense-package.scm
;;; 稠密型多项式安装包

(define (install-poly-dense-package)
  ;;internal procedures
  (define (make-poly-dense variable coeff-list)
    (cons variable coeff-list))

  (define (variable p) (car p))
  (define (coeff-list p) (cdr p))

  ;; 得到第一个系数
  (define (first-coeff coeff-list)
    (car coeff-list))
  
  ;; 求第一个系数的相应的次数
  (define (order-first-coeff coeff-list)
    (- (length coeff-list) 1))
	
  ;; 得到剩下的系数表
  (define (rest-coeffs coeff-list)
    (cdr coeff-list))
  
  ;; 将系数表转换为项表
  (define (coeff-to-term-list c-list)
	(if (null? c-list)
		'()
		(let ((c1 (first-coeff c-list))
			  (o1 (order-first-coeff c-list)))
		  (adjoin-term (make-term o1 c1)
					   (coeff-to-term-list (rest-coeffs c-list))))))
  
  ;; 将dense类型多项式的系数表转换为sparse类型多项式的项表
  (define (term-list p)
	(coeff-to-term-list (coeff-list p)))
  
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'dense x))
  
  (put 'variable '(dense) variable)
  
  (put 'term-list '(dense) term-list)
  
  (put 'make-poly-dense 'dense
       (lambda (var coeffs) (tag (make-poly-dense var coeffs))))
  
  ; 测试
  ;(define c-list-1 (make-coefflist 1 2 0 3))
  ;(display (first-coeff c-list-1))
  ;(display (order-first-coeff c-list-1))
  ;(display (rest-coeffs c-list-1))
  ;(display (coeff-to-term-list c-list-1))
  
  
  'done)

(define (make-coefflist c1 . args) 
    (cons c1 args))

(define (make-poly-dense var coeffs)
    ((get 'make-poly-dense 'dense) var coeffs))

