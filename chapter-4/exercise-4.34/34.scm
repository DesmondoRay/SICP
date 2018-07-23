;;; exercise 4.34
;; 由于需要给表和序对加上标签，并且惰性list的相关定义是直接添加到全局环境内的，
;; 所以，将打印等操作直接定义于全局环境会更简单；
;; 由此需要定义三种构造和选择函数：
;   1、cons-scheme为系统基本过程，以及car-scheme和cdr-scheme（类似于265页 脚注221）
;   2、cons用于构造带标签的惰性list，以及car，cdr
;   3、cons-inner用于构造惰性list，及car-inner和cdr-inner

(load "../common/evaluator-data-structures.scm")
(load "../common/running-evaluator.scm")
(load "../common/representing-expressions.scm")
(load "../common/core-of-evaluator.scm")

(load "../common/lazy-evaluation.scm")
(load "../common/representing-thunks.scm")

;; 修改eval-in-4
(define (eval-in-4 exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp env))  ; 修改，将env添加为参数
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval-in-4 (cond->if exp) env))
        ((application? exp)
         (apply-in-4 (actual-value (operator exp) env)
                     (operands exp)
                     env))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;; 将惰性list加上标签： lazy-list
(define (attach-lazy-list text)
  (list 'cons-scheme "lazy-list"
        (make-list text)))

(define (make-list text)
  (if (null? text) 
      (list 'quote '())
      (list 'cons-inner
            (list 'quote (car text))
            (make-list (cdr text)))))

(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval-in-4 (attach-lazy-list text) env)
        text)))


;; 将各个惰性list的操作加入the-global-environment
; 保存系统基本过程的cons，car，cdr，需要在加载lazy-list之前
(eval-in-4 '(define cons-scheme cons) the-global-environment)
(eval-in-4 '(define car-scheme car) the-global-environment)
(eval-in-4 '(define cdr-scheme cdr) the-global-environment)

(load "../common/lazy-list.scm")
(define-lazy-list-in-env the-global-environment)
; 保存4.2.3节的cons，car，cdr定义
(eval-in-4 '(define (cons-inner x y) (lambda (m) (m x y))) 
           the-global-environment)
(eval-in-4 '(define (car-inner z) (z (lambda (p q) p))) 
           the-global-environment)
(eval-in-4 '(define (cdr-inner z) (z (lambda (p q) q))) 
           the-global-environment)

; 用新的cons，car，cdr代替4.2.3节的
(eval-in-4 '(define (car l) (car-inner (true-list l)))
           the-global-environment)
(eval-in-4 '(define (cdr l) (cdr-inner (true-list l)))
           the-global-environment)
(eval-in-4 '(define (cons x y)
              (cons-scheme "lazy-cons" ; cons操作，给序对添加标签
                           (cons-inner x y)))
           the-global-environment)

; 定义print，打印list或cons
(eval-in-4 '(define (print l)
              (define (print-inner l depth)
                (if (>= depth 10)
                    (display "......")
                    (if (eq? l '())
                        'done
                        (begin (display (car l))
                               (display " ")
                               (print-inner (cdr l) (+ 1 depth))))))
              (if (equal? (car-scheme l) "lazy-cons")
                  (begin (display (car l))
                         (display " ")
                         (display (cdr l))
                         'done)
                  (print-inner (true-list l) 0)))
           the-global-environment)

; true-list过程去掉表或序对的标签
(eval-in-4 '(define (true-list l)
              (if (string? (car-scheme l))
                  (cdr-scheme l)
                  l))
           the-global-environment)


;; test
(driver-loop)

#|
;;; L-Eval input:
(define a '(1 2 3))

;;; L-Eval value:
ok

;;; L-Eval input:
(print a)
1 2 3 
;;; L-Eval value:
done

;;; L-Eval input:
(car a)

;;; L-Eval value:
1

;;; L-Eval input:
(car (cdr a))

;;; L-Eval value:
2

;;; L-Eval input:
(define b (cons 1 2))

;;; L-Eval value:
ok

;;; L-Eval input:
(print b)
1 2
;;; L-Eval value:
done

;;; L-Eval input:
(print integers)
1 2 3 4 5 6 7 8 9 10 ......
;;; L-Eval value:
#!unspecific

;;; L-Eval input:
(print ones)
1 1 1 1 1 1 1 1 1 1 ......
;;; L-Eval value:
#!unspecific

|#
