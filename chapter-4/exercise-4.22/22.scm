;;; exercise 4.22

; (load "../common/analyze-execute.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let-vars exp) (map car (cadr exp)))

(define (let-vals exp) (map cadr (cadr exp)))

(define (let-body exp) (cddr exp))

(define (analyze-let exp)
  (analyze (let->combination exp)))

(define (make-application operator operands)
  (cons operator operands))

(define (let->combination exp)
  (make-application (make-lambda (let-vars exp) (let-body exp))
                    (let-vals exp)))


#|
;; test
(driver-loop)
;;; M-Eval input: 
(define a 3)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(define b 2)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(let ((c (+ a 1)) 
      (d (+ b 1)))
  (+ c d))

;;; M-Eval value: 
7
|#