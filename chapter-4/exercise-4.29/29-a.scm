;;; exercise 4.29 a)

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")

;; 显示运行所用时间
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read))
        (start-time (runtime)))
    (let ((output (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (display "runtime: ")
      (display (- (runtime) start-time))
      (newline)
      (user-print output)))
  (driver-loop))


#|
;; test1: 带有记忆功能
(driver-loop)

;;; L-Eval input:
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; L-Eval value:
runtime: 0.
ok

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 3.33
6765

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 3.23
6765
|#


;; test2: 没有记忆功能
(define (force-it obj)
  (if (thunk? obj)
      (actual-value (thunk-exp obj) (thunk-env obj))
      obj))

(driver-loop)

#|
;;; L-Eval input:
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; L-Eval value:
runtime: 0.
ok

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 20.04
6765

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 19.910000000000004
6765
|#

;; 可见，带有记忆功能的求值器，计算时间约为3.3秒，
;; 而，没有记忆功能的求值器，计算时间约为20.0秒。
