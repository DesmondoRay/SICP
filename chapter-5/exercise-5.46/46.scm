;;; exercise 5.46

(load "../common/code/load-eceval-compiler.scm")
(load "../common/code/ch5-compiler.scm")

(compile-and-go
 '(define (fib n)
	(if (< n 2)
		n
		(+ (fib (- n 1)) (fib (- n 2))))))

#| output:
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(fib 1)

(total-pushes = 7 maximum-depth = 3)
;;; EC-Eval value:
1

;;; EC-Eval input:
(fib 2)

(total-pushes = 17 maximum-depth = 5)
;;; EC-Eval value:
1

;;; EC-Eval input:
(fib 3)

(total-pushes = 27 maximum-depth = 8)
;;; EC-Eval value:
2

;;; EC-Eval input:
(fib 4)

(total-pushes = 47 maximum-depth = 11)
;;; EC-Eval value:
3

;;; EC-Eval input:
(fib 5)

(total-pushes = 77 maximum-depth = 14)
;;; EC-Eval value:
5
|#