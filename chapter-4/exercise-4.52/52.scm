;;; exercise 4.52

;; 修改analyze，添加if-fail
(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((if-fail? exp) (analyze-if-fail exp))  ; exercise 4.52
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze-let exp))
        ((amb? exp) (analyze-amb exp))
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))))


(define (if-fail? exp) (tagged-list? exp 'if-fail))

(define (if-fail-first exp) (cadr exp))

(define (if-fail-second exp) (caddr exp))

(define (analyze-if-fail exp)
  (let ((first (analyze (if-fail-first exp)))
        (second (analyze (if-fail-second exp))))
    (lambda (env succeed fail)
      (first env
             (lambda (value fail2)
               (succeed value fail))
             (lambda ()
               (second env succeed fail))))))

;; test
#|
(load "../common/amb-evaluator.scm")
(driver-loop)

;;; Amb-Eval input:
(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)

;;; Starting a new problem 
;;; Amb-Eval value:
all-odd

;;; Amb-Eval input:
(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)

;;; Starting a new problem 
;;; Amb-Eval value:
8
|#