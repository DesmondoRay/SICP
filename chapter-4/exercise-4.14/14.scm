;;; exercise 4.14

(load "../exercise-4.03/3.scm")

(driver-loop)

;;; M-Eval input: 
(define (map-1 op l)  ; 自定义的map
  (if (null? l)
      '()
      (cons (op (car l))
            (map-1 op (cdr l)))))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(map-1 car '((2 3) (4 5)))

;;; M-Eval value: 
(2 4)  ; 正常工作

;;; M-Eval input: 
(map car '((2 3) (4 5)))  ; 使用系统的基本过程map
;The object (primitive #[compiled-procedure 13 ("list" #x1) #x1a #x113b052]) 
;is not applicable.  ; 提示错误

#|
原因如下：
输入(map car '((2 3) (4 5)))，判定为application，调用：
(apply (eval (operator exp) env)
       (list-of-values (operands exp) env))
求值procedure: (eval (operator exp) env) => (list 'primitive map)
求值arguments: (list-of-values (operands exp) env) => ((list 'primitive car) 
                                                      (list (list 2 3) (list 4 5)))
以(primitive-procedure? procedure)判定map为基本过程，
调用(apply-primitive-procedure procedure arguments)；
即： (apply map ((list 'primitive car)
                (list (list 2 3) (list 4 5))))

所以才会出现：
The object 
(primitive #[compiled-procedure 13 ("list" #x1) #x1a #x113b052])
is not applicable.

在交互模式下，输入：(display car)；
;;; M-Eval input: 
(display car)
(primitive #[compiled-procedure 13 (list #x1) #x1a #x2273052])
;;; M-Eval value: 
#!unspecific

其中 #[compiled-procedure 13 ("list" #x1) #x1a #x113b052] 即为car及其相关到环境部分
|#
