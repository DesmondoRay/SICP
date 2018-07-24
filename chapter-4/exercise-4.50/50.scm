;;; exercise 4.50

(load "../common/amb-evaluator.scm")

;; 修改analyze，添加ramb
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
        ((ramb? exp) (analyze-ramb exp))  ;; exercise 4.50
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))))

(define (ramb? exp) (tagged-list? exp 'ramb))

(define (ramb-choices exp) (cdr exp))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            (let ((rand-choice (random-choice choices)))
              (rand-choice
               env
               succeed
               (lambda () (try-next (rest-choices choices rand-choice)))))))
      (try-next cprocs))))

(define (random-choice lst)
  (let ((len (length lst)))
    (let ((index (random len)))
      (list-ref lst index))))

(define (rest-choices lst item)
  (filter (lambda (x) (not (eq? item x))) lst))

(ambeval '(define (require p)
            (if (not p) (ramb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))


;; test
(driver-loop)
#|
;;; Amb-Eval input:
(define (equal5)
  (let ((a (ramb 1 2 3 4))
        (b (ramb 1 2 3 4)))
    (require (= (+ a b) 5))
    (list a b)))

;;; Starting a new problem 
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(equal5)

;;; Starting a new problem 
;;; Amb-Eval value:
(2 3)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(3 2)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(1 4)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(4 1)

;;; Amb-Eval input:
try-again

;;; There are no more values of
(equal5)
|#