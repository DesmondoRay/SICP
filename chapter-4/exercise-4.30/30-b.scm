;;; exercise-4.30 b)

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")


#|
;; test1: 使用eval
(driver-loop)

;;; L-Eval input:
(define (p1 x)
  (set! x (cons x '(2)))
  x)

;;; L-Eval value:
ok

;;; L-Eval input:
(p1 1)

;;; L-Eval value:
(1 2)

;;; L-Eval input:
(define (p2 x)
  (define (p e)
	e
	x)
  (p (set! x (cons x '(2)))))

;;; L-Eval value:
ok

;;; L-Eval input:
(p2 1)

;;; L-Eval value:
1
|#

(define (eval-sequence exps env)
  (cond ((last-exp? exps)
         (eval-in-4 (first-exp exps) env))
        (else
         (actual-value (first-exp exps) env)
         (eval-sequence (rest-exps exps) env))))

(driver-loop)
#|
;; test2: 使用 actual-value

;;; L-Eval input:
(define (p1 x)
  (set! x (cons x '(2)))
  x)

;;; L-Eval value:
ok

;;; L-Eval input:
(p1 1)

;;; L-Eval value:
(1 2)

;;; L-Eval input:
(define (p2 x)
  (define (p e)
	e
	x)
  (p (set! x (cons x '(2)))))

;;; L-Eval value:
ok

;;; L-Eval input:
(p2 1)

;;; L-Eval value:
(1 2)
|#