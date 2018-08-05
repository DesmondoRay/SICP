;;; let->combination, from exercise 4.6

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