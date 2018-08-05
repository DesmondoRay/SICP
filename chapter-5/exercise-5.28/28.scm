;;; exercise 5.28

#| 修改后的结果
|           | maximum-depth | total-pushes |
| recursion |    8n + 3     |   34n - 16   |
| iteration |    3n + 14    |   37n + 33   |
|#

;; test
(load "28-eceval.scm")

(define the-global-environment (setup-environment))

(start eceval)

#| <test 1>: recursion
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

(total-pushes = 18 maximum-depth = 11)
;;; EC-Eval value:
1

;;; EC-Eval input:
(factorial 2)

(total-pushes = 52 maximum-depth = 19)
;;; EC-Eval value:
2

;;; EC-Eval input:
(factorial 3)

(total-pushes = 86 maximum-depth = 27)
;;; EC-Eval value:
6

;;; EC-Eval input:
(factorial 4)

(total-pushes = 120 maximum-depth = 35)
;;; EC-Eval value:
24

;;; EC-Eval input:
(factorial 5)

(total-pushes = 154 maximum-depth = 43)
;;; EC-Eval value:
120
|#


#| <test 2>: iteration
;;; EC-Eval input:
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(total-pushes = 3 maximum-depth = 3)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 1)

(total-pushes = 70 maximum-depth = 17)
;;; EC-Eval value:
1

;;; EC-Eval input:
(factorial 2)

(total-pushes = 107 maximum-depth = 20)
;;; EC-Eval value:
2

;;; EC-Eval input:
(factorial 3)

(total-pushes = 144 maximum-depth = 23)
;;; EC-Eval value:
6

;;; EC-Eval input:
(factorial 4)

(total-pushes = 181 maximum-depth = 26)
;;; EC-Eval value:
24

;;; EC-Eval input:
(factorial 5)

(total-pushes = 218 maximum-depth = 29)
;;; EC-Eval value:
120
|#