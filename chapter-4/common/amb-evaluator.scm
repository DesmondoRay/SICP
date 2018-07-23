;;; Structure of the evaluator
;; page 297, 4.3.3

;; 4.1
(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
; (load "../common/core-of-evaluator.scm")
(load "../exercise-4.22/22.scm") ; let

;; 4.3
(load "../common/ambeval-simple-expressions.scm")
(load "../common/ambeval-conditionals-sequences.scm")
(load "../common/ambeval-definitions-assignments.scm")
(load "../common/ambeval-procedure-applications.scm")
(load "../common/ambeval-evaluating-amb-expressions.scm")
(load "../common/ambeval-driver-loop.scm")

(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))

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
        ((let? exp) (analyze-let exp)) ;; exercise 4.22
        ((amb? exp) (analyze-amb exp))
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))))

(define (amb? exp) (tagged-list? exp 'amb))

(define (amb-choices exp) (cdr exp))

(load "../common/ambeval-require-element.scm") ; page 288

; (driver-loop)