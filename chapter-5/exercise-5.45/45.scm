;;; exercise 5.45

(load "../common/code/ch5-compiler.scm")
(load "../common/code/load-eceval-compiler.scm")

(compile-and-go
 '(define (factorial n)
	(if (= n 1)
		1
		(* (factorial (- n 1)) n))))

#| output: 
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 1)

(total-pushes = 7 maximum-depth = 3)
;;; EC-Eval value:
1

;;; EC-Eval input:
(factorial 2)

(total-pushes = 13 maximum-depth = 5)
;;; EC-Eval value:
2

;;; EC-Eval input:
(factorial 3)

(total-pushes = 19 maximum-depth = 8)
;;; EC-Eval value:
6

;;; EC-Eval input:
(factorial 4)

(total-pushes = 25 maximum-depth = 11)
;;; EC-Eval value:
24

;;; EC-Eval input:
(factorial 5)

(total-pushes = 31 maximum-depth = 14)
;;; EC-Eval value:
120
|#