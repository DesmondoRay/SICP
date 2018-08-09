;;; exercise 5.50

;; 注意加载顺序，changed-eceval-support.scm 在 ch5-eceval-compiler 之前
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-regsim")
(load "changed-eceval-support.scm") ; 需要修改，在primitive-procedures里添加一些基本过程
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-eceval-compiler")
(load "/home/desmondo/Documents/git/SICP/chapter-5/common/code/ch5-syntax.scm")

(load "4.1-eval.scm")       ; 4.1节的内容，有一定的增减，见当前文件所在目录下的4.1-eval.scm
(load "../exercise-5.23/let->combination.scm")  ; exercise 4.6
(load "changed-compiler.scm")                   ; ch5-compiler -> changed compiler

;; 增加apply和map，即将这两个定义与m-eval置于同一个环境内；
;; 也可将这两个定义添加到 4.1-eval.scm 的 m-eval 里
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

(define M-eval (list 'begin apply-and-map m-eval))
; 也可写成: (define M-eval `(begin ,apply-and-map ,m-eval))

(compile-and-go M-eval)

#|
(total-pushes = 2933 maximum-depth = 111)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(driver-loop)


;;; M-Eval input: 
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