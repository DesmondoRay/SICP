;;; exercise 4.9
;; while形式到迭代

#|
 for example:
(while (> a 0)
       ((set! b (+ b a))
        (set! a (- a 1))))
相当于C语言： 
while (a > 0)
    b += a--;
|#


(load "../exercise-4.03/3.scm")

(define (while? exp) (tagged-list exp 'while)) ;使用数据导向的话，可省略

(define (while-test exp) (cadr exp))

(define (while-body exp) (caddr exp))

(define while-func-name 'while-iter)

(define (make-application operator operands)
  (cons operator operands))

(define (make-definition func body)
  (list 'define func body))

(define (eval-while exp env)
  (eval-in-4 (while->combination exp) env))

(define (while->combination exp)
  ; 生成while-proc: '(while-iter)，作为一个无参数到过程
  (let ((while-proc (cons while-func-name '())))
    (let ((define-body (make-if (while-test exp)
                                (sequence->exp 
                                 (append (while-body exp) (list while-proc)))
                                'true)))
      (sequence->exp
       (list 
        (make-definition while-proc define-body)  ; 定义(while-iter)
        (make-application while-func-name '())))))) ; 执行(while-iter)

;; 将eval-while加入元循环求值器
(put 'op 'while eval-while)


#|
;; test(交互模式下)
(driver-loop)

;;; M-Eval input: 
(define a 3)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(define b 0)

;;; M-Eval value: 
ok

;;; M-Eval input: 
(while (> a 0)
       ((set! b (+ b a))
        (set! a (- a 1))))

;;; M-Eval value: 
#t

;;; M-Eval input: 
a

;;; M-Eval value: 
0

;;; M-Eval input: 
b

;;; M-Eval value: 
6
|#