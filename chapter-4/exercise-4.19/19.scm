;;; exercise 4.19

(load "../exercise-4.06/6.scm")

#|
;; 使用eval求值器的情况
(driver-loop)

;;; M-Eval input: 
(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))

;;; M-Eval value: 
16

;; 使用mit-scheme的情况
(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))

;Premature reference to reserved name: a
|#

;; 交互模式下输入：
;;; M-Eval input: 
(let ((a 1))
  (define (f x)
    (define b (lambda () (+ a x)))
    (define a 5)
    (+ a (b)))
  (f 10))

;;; M-Eval value: 
20

;; 所以，想使得最终结果为20，可以修改内部的define语句；
;; 即，修改带有内部定义到过程体，修改每一个内部定义以及过程部分body；
;; 相当于给内部定义的变量添加一个delay，并在body中对该变量进行force求值，
;; 参考242页的integral过程