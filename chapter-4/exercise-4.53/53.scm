;;; exercise 4.53

(load "../common/amb-evaluator.scm")

;; 修改analyze，添加if-fail, permanent-set?
(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((permanent-set? exp) (analyze-permanent-set exp)) ;; exercise 4.51
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

(define (permanent-set? exp) (tagged-list? exp 'permanent-set!))

(define (analyze-permanent-set exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (set-variable-value! var val env)
               (succeed 'ok fail2))
             fail))))

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

(load "define-prime?-in-ambeval.scm")

;; test
(driver-loop)
;; 注：将let改为define形式，因为使用的是练习4.22的let，即4.1节里的let，4.3节内的一些情况下不适用。
#|
;;; Amb-Eval input:
(define pairs '())
(if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
           (permanent-set! pairs (cons p pairs))
           (amb))
         pairs)
;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:


;;; Starting a new problem 
;;; Amb-Eval value:
((8 35) (3 110) (3 20))

;;; Amb-Eval input:
try-again

;;; There are no more values of
(if-fail (let ((p (prime-sum-pair (quote (1 3 5 8)) (quote (20 35 110))))) 
           (permanent-set! pairs (cons p pairs)) (amb)) pairs)
|#