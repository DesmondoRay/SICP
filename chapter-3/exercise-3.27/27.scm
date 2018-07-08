;;; 27.scm

(load "table.scm")

(define (fib n)
  (cond ((= n 0) 0)
		((= n 1) 1)
		(else (+ (fib (- n 1))
				 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
	(lambda (x)
	  (let ((previously-computed-result (lookup x table)))
		(or previously-computed-result
			(let ((result (f x)))
			  (insert! x result table)
			  result))))))

(define memo-fib
  (memoize (lambda (n)
			 (cond ((= n 0) 0)
				   ((= n 1) 1)
				   (else (+ (memo-fib (- n 1))
							(memo-fib (- n 2))))))))

(define memo-fib-1 (memoize fib))


;; test
(define start-time-1 (runtime))
(memo-fib 35)
(define start-time-2 (runtime))
(display "(memo-fib 35):   ")
(display (- start-time-2 start-time-1))
(newline)

(memo-fib-1 35)
(define start-time-3 (runtime))
(display "(memo-fib-1 35): ")
(display (- start-time-3 start-time-2))

;; 结果:
;	(memo-fib 35):   0.
;	(memo-fib-1 35): 11.180000000000007
; 可见将memo-fib定义为(memoize fib)，不能改善程序性能
