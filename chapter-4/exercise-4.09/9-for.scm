;;; exercise 4.9
;; for形式到迭代

#|
注：不考虑初始化和更新为多条语句到情况；
   可以将多余的初始化语句放在for循环外部，将多余的更新语句放在for循环内部。
for example:
(for ((set! i 1) 
      (< i 5) 
      (set! i (+ 1 i)))
	 ((set! a (+ a i))
	  (set! b (* b i))))
相当于C语言： 
for (i = 1; i < 5; i++) {
    a += i;
    b *= i;
}
|#

(load "../exercise-4.03/3.scm")

(define (for? exp) (tagged-list exp 'for)) ; 使用数据导向的话，可省略

(define (for-initialize exp) (car (cadr exp)))  ; 初始化：(set! i 1)

(define (for-test exp) (cadr (cadr exp))) ; 测试语句：(< i 5)

(define (for-update exp) (caddr (cadr exp))) ; 更新语句：(set! i (+ 1 i))

(define (for-body exp) (caddr exp))

#| 测试for语句到选择函数：
(define f '(for ((set! i 1) (< i 5) (set! i (+ 1 i)))
                ((set! a (+ a i))
                 (set! b (* b i)))))

(load "../common/print.scm")
(print (for-initialize f)
       (for-test f)
       (for-update f)
       (for-body f))
output:
(set! i 1)
(< i 5)
(set! i (+ 1 i))
((set! a (+ a i)) (set! b (* b i)))
|#

(define for-func-name 'for-iter)

(define (make-application operator operands)
  (cons operator operands))

(define (make-definition func body)
  (list 'define func body))

(define (eval-for exp env)
  (eval-in-4 (for->combination exp) env))

(define (for->combination exp)
  ; 生成for-proc: '(for-iter)，作为一个无参数到过程
  (let ((for-proc (cons for-func-name '())))
    (let ((define-body (make-if (for-test exp)
								(sequence->exp
								 (append (for-body exp)
										 (list (for-update exp) for-proc)))
								'true)))
	  (sequence->exp
	   (list
		(for-initialize exp)  ; 初始化
		(make-definition for-proc define-body)  ; 定义(for-iter)
		(make-application for-func-name '()))))))  ; 执行(for-iter)

;; 将eval-for加入元循环求值器
(put 'op 'for eval-for)


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define a 0)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(define b 1)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(define i 0)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(for ((set! i 1) (< i 5) (set! i (+ 1 i)))
	 ((set! a (+ a i))
	  (set! b (* b i))))

;;; M-Eval value: 
#t

;;; M-Eval input: 
a

;;; M-Eval value: 
10

;;; M-Eval input: 
b

;;; M-Eval value: 
24

;;; M-Eval input: 
i

;;; M-Eval value: 
5
|#