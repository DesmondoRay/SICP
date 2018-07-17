;;; exercise 4.6
;; let语句的样式(list 'let ((<var><exp>)..) <body>)

(load "../exercise-4.03/3.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let-vars exp) (map car (cadr exp)))

(define (let-exps exp) (map cadr (cadr exp)))

(define (let-body exp) (cddr exp))

(define (eval-let exp env)
  (eval-in-4 (let->combination exp) env))

(define (make-application operator operands)
  (cons operator operands))

(define (let->combination exp)
  (make-application (make-lambda (let-vars exp) (let-body exp))
                    (let-exps exp)))

;; 将eval-let加入table
(put 'op 'let eval-let)

;; 或者在eval过程中加入：
;   ((let? exp) (eval-let exp env))


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(let ((a 3) 
      (b 4)) 
  (+ a b))

;;; M-Eval value: 
7
|#