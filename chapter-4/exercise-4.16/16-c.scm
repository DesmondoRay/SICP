;;; exercise 4.16 c)

;; 需要将scan-out-defines安装到make-procedure，
;; 不然每次调用程序时都需要执行scan-out-defines

(define (make-procedure parameters body env)
  (display "*** 4.16 test -- make-procedure ***")
  (list 'procedure parameters (scan-out-defines body) env))