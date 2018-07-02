;;; poly-dense

(define (make-poly-dense variable coeff-list)
  (cons variable coeff-list))

(define (variable p) (car p))
(define (coeff-list p) (cdr p))

(define (make-coefflist c1 . args) 
  (cons c1 args))

(define (first-coeff coeff-list)
  (car coeff-list))

(define (order-first-coeff coeff-list)
  (- (length coeff-list) 1))

(define (rest-coeffs coeff-list)
  (cdr coeff-list))

;;; 测试
(define c-list (make-coefflist 1 2 0 3 -2 -5))
(define p (make-poly-dense 'x c-list))
(newline)
(display p)
(newline)
(display (coeff-list p))
(newline)
(display (first-coeff (coeff-list p)))
(newline)
(display (order-first-coeff (coeff-list p)))
(newline)
(display (rest-coeffs (coeff-list p)))

