;;; exercise 4.24

;; test1
; (load "../exercise-4.03/3.scm")

;; test2
(load "../exercise-4.22/22.scm")

;; 显示运行所用时间
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read))
        (start-time (runtime)))
    (let ((output (eval-in-4 input the-global-environment)))
      (announce-output output-prompt)
      (display "runtime: ")
      (display (- (runtime) start-time))
      (newline)
      (user-print output)))
  (driver-loop))

#|
;; test1: 测试原版本的求值器
(driver-loop)

;;; M-Eval input: 
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; M-Eval value: 
runtime: 0.
ok

;;; M-Eval input: 
(fib 22)

;;; M-Eval value: 
runtime: 6.37
17711
|#


;; test2: 测试改进的求值器
(driver-loop)

;;; M-Eval input: 
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;;; M-Eval value: 
runtime: 0.
ok

;;; M-Eval input: 
(fib 22)

;;; M-Eval value: 
runtime: 3.8400000000000003
17711

;; 可见，改进版本的运行时间从6.37秒减少到了3.84秒，所需时间约为原版本的60%左右。
