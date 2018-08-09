;;; exercise 5.50

;; 注意加载顺序，changed-eceval-support.scm 在 ch5-eceval-compiler 之前
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-regsim")
; 修改ch-eceval-support，在primitive-procedures里添加一些基本过程
(load "changed-eceval-support.scm")
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval-compiler")
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-syntax.scm")

(load "4.1-eval.scm")         ; 4.1节的内容，有一定的增减，见当前文件所在目录下的4.1-eval.scm
(load "exercise-4.6-let.scm") ; exercise 4.6
(load "changed-compiler.scm") ; 修改ch5-compiler，在compile过程中添加对let语句的翻译

;; 增加apply和map的定义，即将这两个定义与m-eval置于同一个环境内；
;; 也可将这两个定义添加到 4.1-eval.scm 的 evaluator 里
(define apply-and-map
  '(begin
    (define (apply proc args)
      (if (null? (cdr args))
          (car args)
          (proc (car args)
                (apply proc (cdr args)))))
    (define (map proc items)
      (if (null? items)
          '()
          (cons (proc (car items))
                (map proc (cdr items)))))
     ))

(define m-eval (list 'begin apply-and-map evaluator))
; 也可写成: (403页，脚注321)
; (define M-eval `(begin ,apply-and-map ,evaluator))

(compile-and-go m-eval)

#|
(total-pushes = 2933 maximum-depth = 111)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(driver-loop)


;;; M-Eval input:           ;; 进入元循环求值器
(define (fact n)
  (if (= n 1)
      1
      (* (fact (- n 1)) n)))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(fact 5)

;;; M-Eval value: 
120

;;; M-Eval input: 
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; M-Eval value: 
ok

;;; M-Eval input: 
(fib 5)

;;; M-Eval value: 
5
|#