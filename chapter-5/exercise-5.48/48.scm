;;; exercise 5.48

(load "../common/code/ch5-compiler.scm")
(load "../common/code/load-eceval-compiler.scm")

#| wrong!!!
;; 这种方法看似可行，但是调用compile-and-run过程，会创建一个新的全局环境，并且不能返回到原来的环境。

(set! primitive-procedures
      (append primitive-procedures
              (list 
               (list 'compile-and-run compile-and-go))))

(compile-and-go
 '(define (f x) x))

;; output:
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(compile-and-run
 '(define (fact n)
    (if (= n 1)
        1
        (* (fact (- n 1)) n))))

(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(fact 5)

(total-pushes = 31 maximum-depth = 14)
;;; EC-Eval value:
120

;;; EC-Eval input:
(f 5)
;Unbound variable f     ;; 调用原来环境的f过程，提示出错；
|#

(define (compile-and-run? exp) (tagged-list? exp 'compile-and-run))

(define (compile-body exp) (text-of-quotation (cadr exp))) ; 需要调用text-of-quotation

(define (compile-and-assemble exp)
  (assemble (statements
             (compile exp 'val 'return))
            eceval))

(load "../exercise-5.48/48-changed-eceval-compiler.scm")

#| test
(compile-and-go
 '(define (f x) x))

output:
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(compile-and-run
 '(define (fact n)
    (if (= n 1)
        1
        (* (fact (- n 1)) n))))

(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(fact 5)

(total-pushes = 31 maximum-depth = 14)
;;; EC-Eval value:
120

;;; EC-Eval input:
(f 5)

(total-pushes = 5 maximum-depth = 3)
;;; EC-Eval value:
5
|#
