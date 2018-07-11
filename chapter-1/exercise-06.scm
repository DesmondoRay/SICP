;;; exercise-6.scm

(load "common/sqrt-iter.scm")

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
		(else else-clause)))

(define (sqrt-iter-e6 guess x)
  (new-if (good-enough? guess x)
		  guess
		  (sqrt-iter-e6 (improve guess x)
					 x)))

;; test
(sqrt-iter-e6 1.0 5)
; 结果:
;	Aborting!: maximum recursion depth exceeded
; 提示超出最大递归深度

;; if语句的两个分支，只有一个会被求值，而 new-if 是我们定义的一个普通函数，
;; 参考练习1.5，scheme采用应用序求值，所以会对后面的两个参数求值，并一直递归下去。