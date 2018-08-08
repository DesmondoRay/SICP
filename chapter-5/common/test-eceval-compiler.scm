;;; test eceval-compiler

(load "code/ch5-compiler.scm")
(load "code/load-eceval-compiler.scm")

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
(factorial 5)

(total-pushes = 31 maximum-depth = 14)
;;; EC-Eval value:
120
|#