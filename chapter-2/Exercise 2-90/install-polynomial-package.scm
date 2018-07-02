;;; install-polynomial-package.scm

(define (install-polynomial-package)
  ;;imported procedures from dense and sparse packages
  (define (make-poly-sparse var terms)
    ((get 'make-poly-sparse 'sparse) var terms))
  (define (make-poly-dense var coeffs)
    ((get 'make-poly-dense 'dense) var coeffs))

  ;; internal procedures
  ;; representation of arithmetic
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	    (make-poly-sparse (variable p1)
						  (add-terms (term-list p1)
									 (term-list p2)))
	    (error "Polys not in same var -- ADD-POLY"
			   (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	    (make-poly-sparse (variable p1)
						  (mul-terms (term-list p1)
									 (term-list p2)))
	    (error "Polys not in same var -- MUL-POLY"
			   (list p1 p2))))
  
  (define (add-terms L1 L2)
	(cond ((empty-termlist? L1) L2)
		  ((empty-termlist? L2) L1)
		  (else
		   (let ((t1 (first-term L1)) 
				 (t2 (first-term L2)))
			 (cond ((> (order t1) (order t2))
					(adjoin-term
					 t1 (add-terms (rest-terms L1) L2)))
				   ((< (order t1) (order t2))
					(adjoin-term
					 t2 (add-terms L1 (rest-terms L2))))
					(else
					 (adjoin-term
					  (make-term (order t1)
								 (add (coeff t1) (coeff t2)))
					  (add-terms (rest-terms L1)
								 (rest-terms L2)))))))))
  
  (define (mul-terms L1 L2)
	(if (empty-termlist? L1)
		(the-empty-termlist)
		(add-terms (mul-term-by-all-terms (first-term L1) L2)
				   (mul-terms (rest-terms L1) L2))))
  
  (define (mul-term-by-all-terms t1 L)
	(if (empty-termlist? L)
		(the-empty-termlist)
		(let ((t2 (first-term L)))
		  (adjoin-term
		   (make-term (+ (order t1) (order t2))
					  (mul (coeff t1) (coeff t2)))
		   (mul-term-by-all-terms t1 (rest-terms L))))))
  
  ;; exercise 2-88的多项式减法
  (define (sub-poly p1 p2)
	(make-poly-sparse (variable p1)
						    (add-terms (term-list p1)
									   (neg-terms (term-list p2)))))

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
	   (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
	   (lambda (p1 p2) (tag (mul-poly p1 p2))))
  
  (put 'make-sparse 'polynomial
	   (lambda (var terms) (tag (make-poly-sparse var terms))))
  
  (put 'make-dense 'polynomial
	   (lambda (var coeffs) (tag (make-poly-dense var coeffs))))
  
  ;; exercise 2-88的多项式减法
  (put 'sub '(polynomial polynomial)
	   (lambda (p1 p2) (tag (sub-poly p1 p2))))
  
  ;; =zero?
  (put '=zero? '(polynomial)
	   (lambda (poly)
			 (coeff=0? (term-list poly))))
  
  ;; 判断term-list内的每一项的系数是否等于0
  (define (coeff=0? term-lists)
	(if (null? term-lists)
		#t
		(and (= 0 (coeff (first-term term-lists)))
			 (coeff=0? (rest-terms term-lists)))))
  
  (put 'variable '(polynomial) variable)
  
  (put 'term-list '(polynomial) term-list)
  
  'done)

(define (variable? v) (symbol? v))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;; representation of terms and term lists
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
	  term-list
	  (cons term term-list)))
  
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-polynomial-dense var coeffs)
  ((get 'make-dense 'polynomial) var coeffs))

(define (make-polynomial-sparse var terms)
  ((get 'make-sparse 'polynomial) var terms))

