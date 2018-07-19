;;; exercise 4.31 test

(load "31.scm")


;; <test1: lazy声明，如练习4.27>
#|
(driver-loop)

;;; L-Eval input:
(define count 0)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (id (x lazy))   ; 带lazy声明
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
**************************************
;;; L-Eval input:
(define count 0)

;;; L-Eval value:
ok

;;; L-Eval input:
(define (id x)         ; 不带lazy声明
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
2

;;; L-Eval input:
w

;;; L-Eval value:
10

;;; L-Eval input:
count

;;; L-Eval value:
2
**************************************
|#


;; <test2: memo声明>

;; 显示运行所用时间
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read))
        (start-time (runtime)))
    (let ((output (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (display "runtime: ")
      (display (- (runtime) start-time))
      (newline)
      (user-print output)))
  (driver-loop))


(driver-loop)
#|
;;; L-Eval input:
(define (fib (n lazy-memo))  ; 带memo声明的
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; L-Eval value:
runtime: 0.
ok

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 3.6100000000000003
6765
**************************************
;;; L-Eval input:
(define (fib (n lazy))   ; 不带memo声明的
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; L-Eval value:
runtime: 0.
ok

;;; L-Eval input:
(fib 20)

;;; L-Eval value:
runtime: 23.630000000000003
6765
|#
