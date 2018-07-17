;;; exercise 4.12

;; 将scan定义在外部
(define (scan vars vals var)
  (cond ((null? vars)
		 '())
		((eq? var (car vars))
		 vals)
		(else (scan (cdr vars) (cdr vals) var))))

(define (lookup-variable-value var env)
  (display "*** 4.12 test -- lookup-variable-value ***") ; 用于测试
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (let ((scan-result (scan (frame-variables frame)
                                   (frame-values frame)
                                   var)))
            (if (null? scan-result)
                (env-loop (enclosing-environment env))
                (car scan-result))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (display "*** 4.12 test -- set-variable-value! ***") ; 用于测试
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let ((frame (first-frame env)))
		  (let ((scan-result (scan (frame-variables frame)
                               (frame-values frame)
                               var)))
        (if (null? scan-result)
            (env-loop (enclosing-environment env))
            (set-car! scan-result val))))))
  (env-loop env))

(define (define-variable! var val env)
  (display "*** 4.12 test -- define-variable! ***") ; 用于测试
  (let ((frame (first-frame env)))
    (let ((scan-result (scan (frame-variables frame)
                             (frame-values frame)
                             var)))
      (if (null? scan-result)
          (add-binding-to-frame! var val frame)
          (set-car! scan-result val)))))
