;;; 14.scm

(define (mystery x)
  (define (loop x y)
	(if (null? x)
		y
		(let ((temp (cdr x)))
		  (set-cdr! x y)
		  (loop temp x))))
  (loop x '()))

;; test
(define v (list 'a 'b 'c))
(newline)
(display v)
(define w (mystery v))
(newline)
(display v)
(newline)
(display w)
(newline)

#|
结果输出：
  (a b c)
  (a)
  (c b a)
注意: v始终指向'a
|#