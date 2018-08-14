;;; exercise 1.35

(load "exercise-35-fixed-point.scm")

#| test: 第一种生成一个分数，利用exact->inexact过程，将结果转换为浮点数
1 ]=> (exact->inexact(fixed-point (lambda (x) (+ 1 (/ 1 x)))
                            1))

;Value: 1.618032786885246

1 ]=> (fixed-point (lambda (x) (+ 1.0 (/ 1.0 x)))
                            1)

;Value: 1.6180327868852458
|#