;;; 19.scm
;;; 使用两个变量，一个变量以步长为1遍历列表，另一个变量以步长为2遍历列表，
;;; 每次在两个变量移动之后对比它们，如果两个变量相遇，那么列表有环；
;;; 如果能走完整个列表（遇到 '() ），那么列表没有环。

(define (cycle? x) 
   (define (iter one-step two-step) 
     (cond ((or (not (pair? one-step))
			    (not (pair? two-step)))
			#f)
           ((eq? one-step two-step) #t)
           (else 
			(iter (safe-cdr one-step) 
				  (safe-cdr (safe-cdr two-step))))))
   (iter (safe-cdr x) (safe-cdr (safe-cdr x))))

(define (safe-cdr l)
  (if (pair? l) 
	  (cdr l) 
	  '())) 

;; test: x本身为环
(define x '(a b c))
(newline)
(display (cycle? x))
(newline)
(display (cycle? (append! x x)))
(newline)
; 输出：
;	#f
;	#t

;; 注: 只考虑整个列表为环的情况，包含环的情况见exercise-3.18/18.scm