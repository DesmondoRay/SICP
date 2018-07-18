;;; exercise 4.20

(load "../exercise-4.06/6.scm")

(define (letrec? exp) (tagged-list? exp 'letrec))

(define (letrec-vars exp) (map car (cadr exp)))

(define (letrec-vals exp) (map cadr (cadr exp)))

(define (letrec-body exp) (cddr exp))

(define (eval-letrec exp env)
  (eval-in-4 (letrec->combination exp) env))

(define (letrec->combination exp)
  (let ((let-part (map (lambda (x)
                         (list x "*unassigned*"))
                       (letrec-vars exp)))
        (set!-part (map (lambda (x y)
                          (list 'set! x y))
                        (letrec-vars exp) (letrec-vals exp))))
    
    (append (list 'let let-part)
            set!-part
            (letrec-body exp))))

;; 将eval-let加入求值器
(put 'op 'letrec eval-letrec)


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(letrec ((fact
          (lambda (n)
            (if (= n 1)
                1
                (* n (fact (- n 1)))))))
  (fact 10))

;;; M-Eval value: 
3628800
|#


#|
;; test: letrec->combination
(define test '(letrec ((even?
                        (lambda (n)
                          (if (= n 0)
                              true
                              (odd? (- n 1)))))
                       (odd?
                        (lambda (n)
                          (if (= n 0)
                              false
                              (even? (- n 1))))))
                (even? x)))

(newline)
(display (letrec->combination test))


(let ((even? *unassigned*) 
      (odd? *unassigned*)) 
  (set! even? (lambda (n) 
                (if (= n 0) 
                    true 
                    (odd? (- n 1)))))
  (set! odd? (lambda (n) 
               (if (= n 0) 
                   false 
                   (even? (- n 1)))))
  (even? x))
|#