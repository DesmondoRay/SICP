;;; exercise 4.27

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")


#|
;; test
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
(define w (id (id 10)))

;;; L-Eval value:
ok

;;; L-Eval input:
count

;;; L-Eval value:
1

;;; L-Eval input:
w

;;; L-Eval value:
10

;;; L-Eval input:
count

;;; L-Eval value:
2
|#


#| 解释：
第2个 count = 2 以及 w = 10 不需要多说明，重点是第一个count的值为1；
在将(define w (id (id 10)))传入求值器时，--> (eval-definition exp env)；
执行eval-definition过程，如255页所示：
    (define (eval-definition exp env)
      (define-variable! (definition-variable exp)
                        (eval (definition-value exp) env)
                        env)
      'ok)

(definition-variable exp) --> w
(eval (definition-value exp) env) --> (eval (id (id 10)) env)
因为id是一个过程，从而执行 
((application? exp)
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))

(actual-value (operator exp) env) --> 将count + 1，返回(id 10)，
apply过程将 (operands exp)， 即(id 10)，作为参数传入list-of-delayed-args，
从而将(id 10)变换为一个 槽(thunk) 的对象，
所以求值 w 时，再一次调用过程 id，使 count + 1
|#
