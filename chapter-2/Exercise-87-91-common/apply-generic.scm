;;; apply-generic.scm

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (let ((diff (higher? type1 type2)))
						  (cond ((= 0 diff) 
								 (error "No method for these types" (list op type-tags)))
								((> 0 diff) 
								 (apply-generic op (raise a1) a2 ))
								(else (apply-generic op a1 (raise a2))))))
                    (error "No method for these types"
                            (list op type-tags)))))))

;;; 新增的过程: 比较type1和type2两个类型哪个更高
(define (higher? t1 t2)
  (define (type-val t) 
    (cond
      ((eq? t 'scheme-number) 1)
      ((eq? t 'rational) 2)
      ((eq? t 'real) 3)
      ((eq? t 'complex) 4)
	  ((eq? t 'polynomial) 5)
      (else (error "No such type" t))))
  (- (type-val t1) (type-val t2)))