;;; exercise 4.16 a)

(load "../exercise-4.06/6.scm")

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
                 (error "Unassigned variablse -- LOOK-VARIABLE-VALUE"
                        (car vars))
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))


#|
;; test

(driver-loop)
;;; M-Eval input: 
(let ((a '*unassigned*) (b 0))  
  (display b)
  (display a))

;; output:
0
;Unassigned variablse -- LOOK-VARIABLE-VALUE a
|#