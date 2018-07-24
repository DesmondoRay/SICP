;;; exercise 4.54

(load "../common/amb-evaluator.scm")

;; 修改analyze，添加require
(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze-let exp))
        ((amb? exp) (analyze-amb exp))
        ((require? exp) (analyze-require exp))
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))))

(define (require? exp) (tagged-list? exp 'require))

(define (require-predicate exp) (cadr exp))

(define (analyze-require exp)
  (let ((pproc (analyze (require-predicate exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (pred-value fail2)
               (if (not (true? pred-value))
                   (fail2)
                   (succeed 'ok fail2)))
             fail))))


;; test
(driver-loop)
#|
;;; Amb-Eval input:
(define (equal5)
  (let ((a (amb 1 2 3 4))
        (b (amb 1 2 3 4)))
    (require (= 5 (+ a b)))  
    (list a b)))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(equal5)

;;; Starting a new problem 
;;; Amb-Eval value:
(1 4)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(2 3)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(3 2)
|#