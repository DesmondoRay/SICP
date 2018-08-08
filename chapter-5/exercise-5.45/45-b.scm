;;; exercise 5.45 b)

;; 利用练习5.38，优化编译器
;; 得到的结果为 
;   total-pushes = 2n + 3;
;   maximum-depth = 2n - 2; (n >= 3)
;; maximum-depth与手工版本基本相同，total-pushes更接近于手工版本。

(load "../common/code/load-eceval-compiler.scm")
(load "changed-eceval-compiler.scm") ; 修改ch5-eceval-compiler.scm，修改处用******标记
(load "../common/code/ch5-compiler.scm")
(load "../exercise-5.38/better-solution/38-d.scm")

(compile-and-go
 '(define (factorial n)
    (if (= n 1)
        1
        (* (factorial (- n 1)) n))))

#|
(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 2)

(total-pushes = 7 maximum-depth = 3)
;;; EC-Eval value:
2

;;; EC-Eval input:
(factorial 3)

(total-pushes = 9 maximum-depth = 4)
;;; EC-Eval value:
6

;;; EC-Eval input:
(factorial 4)

(total-pushes = 11 maximum-depth = 6)
;;; EC-Eval value:
24

;;; EC-Eval input:
(factorial 5)

(total-pushes = 13 maximum-depth = 8)
;;; EC-Eval value:
120
|#