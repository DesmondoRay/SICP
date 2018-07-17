;;; exercise 4.11
;; 需要修改的点

(define (make-frame variables values)
  (cons 'frame (map cons variables values)))

(define (frame-pairs frame) (cdr frame))

(define (first-pair frame) (car frame))

(define (rest-pairs frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (display "*** 4.11 test -- add-binding-to-frame! ***") ; 用于测试
  (set-cdr! frame (cons (cons var val) (cdr frame))))

;; 将scan定义在外部
(define (scan frame var)
  (if (null? frame)
	  '()
	  (if (eq? var (car (first-pair frame)))
		  (first-pair frame)
		  (scan (rest-pairs frame) var))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (frame-pairs (first-frame env))))
          (let ((scan-result (scan frame var)))
            (if (null? scan-result)
                (env-loop (enclosing-environment env))
                (cdr scan-result))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let ((frame (frame-pairs (first-frame env))))
		  (let ((scan-result (scan frame var)))
        (if (null? scan-result)
            (env-loop (enclosing-environment env))
            (set-cdr! scan-result val))))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (frame-pairs (first-frame env))))
    (let ((scan-result (scan frame var)))
      (if (null? scan-result)
          (add-binding-to-frame! var val frame)
          (set-cdr! scan-result val)))))