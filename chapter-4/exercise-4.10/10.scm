;;; exercise 4.10

;; 参考练习 2.58，可以将: (+ x (* 3 (+ x (+ y 2))))
;; 转换为一种新的表示形式: (x + (3 * (x + (y + 2))))
;; 例如，我们可以将（+ x y）换成 （x + y）
;; 注：对于很多操作来说，使用scheme原本的形式更方便，
;  如(+ 1 2 3),而不是(1 + 2 + 3)，因为 + 过程可以接受可变数量参数

;; 作为练习:
;	定义(x ^ y)，计算x的y次方，相当于(expt x y)
;	定义(x % y)，计算x除以y的余数，相当于(remainder x y)

(load "../exercise-4.03/3.scm")

(define (first-operand exp) (car exp)) ; 第1个操作数

(define (operator exp) (cadr exp))  ; 操作符

(define (second-operand exp) (caddr exp)) ; 第2个操作数

(define (operands exp) 
  (list (first-operand exp) (second-operand exp)))				 


#|
;;test 
(define new-syntax (list 2 expt 3))
(load "../common/print.scm")
(print (operator new-syntax)
	   (operands new-syntax))
output:
#[compiled-procedure 13 (arith #xdd) #x1a #x11fd70a]
(2 3)
|#

;; 定义新操作
(define new-operator 
  (list (list '^ expt)
        (list '% remainder)))

;; 新操作的符号
(define (new-operator-names)
  (map car new-operator))

;; 为简化起见，将新操作作为基本过程
(define (new-operator-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       new-operator))

;; 为简化起见，将新操作直接添加到the-global-environment
(define (new-environment)
  (extend-environment (new-operator-names)
                      (new-operator-objects)
                      the-global-environment))

(set! the-global-environment (new-environment))


;; test(交互模式下)
(driver-loop)
#|
;;; M-Eval input: 
 (2 ^ 4)

;;; M-Eval value: 
16

;;; M-Eval input: 
(7 % 3)

;;; M-Eval value: 
1
|#