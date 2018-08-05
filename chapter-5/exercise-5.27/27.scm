;;; exercise 5.27

#|
|           | maximum-depth | total-pushes |
| recursion |    5n + 3     |   32n - 16   |
| iteration |      10       |   35n + 29   |
|#

;; test
(load "../common/code/load-eceval.scm")

(define the-global-environment (setup-environment))

(start eceval)

#|
;;; EC-Eval input:
(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

(total-pushes = 3 maximum-depth = 3)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 1)

(total-pushes = 16 maximum-depth = 8)
;;; EC-Eval value:
1

;;; EC-Eval input:
(factorial 2)

(total-pushes = 48 maximum-depth = 13)
;;; EC-Eval value:
2

;;; EC-Eval input:
(factorial 3)

(total-pushes = 80 maximum-depth = 18)
;;; EC-Eval value:
6

;;; EC-Eval input:
(factorial 4)

(total-pushes = 112 maximum-depth = 23)
;;; EC-Eval value:
24

;;; EC-Eval input:
(factorial 5)

(total-pushes = 144 maximum-depth = 28)
;;; EC-Eval value:
120
|#