;;; exercise 4.29 b)

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")

#|
;; test1: 带有记忆功能
(driver-loop)

;;; L-Eval input:
(define count 0)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (id x)
  (set! count (+ count 1))
  x)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (square x)
  (* x x))

;;; L-Eval value:
ok

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
100

;;; L-Eval input:
count

;;; L-Eval value:
1
|#

;; test2: 没有记忆功能
(define (force-it obj)
  (if (thunk? obj)
      (actual-value (thunk-exp obj) (thunk-env obj))
      obj))

#|
(driver-loop)

;;; L-Eval input:
(define count 0)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (id x)
  (set! count (+ count 1))
  x)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (square x)
  (* x x))

;;; L-Eval value:
ok

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
100

;;; L-Eval input:
count

;;; L-Eval value:
2
|#

;; 带有记忆功能的求值器，只对(id 10)求值了一次；
;; 没有记忆功能的求值器，计算square时，每次求值x时，都对(id 10)求值了一次。
